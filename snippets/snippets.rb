command 'gem' do |cmd|
  cmd.scope = 'source.ruby'
  cmd.trigger = 'gem'
  cmd.output = :insert_as_snippet
  cmd.input = :word, :clipboard
  cmd.invoke do |context|
    require "ruble/ui"
    
    default_string = $stdin.read
    
    # TODO Grab unique names of locally installed gems here and put them as suggestions?
    if gem_name = Ruble::UI.request_string(:title => 'Enter gem name:', :default => default_string)
      output = `gem list --local #{gem_name}`
      lines = output.chomp.split(/\r\n|\r|\n/)
      line = lines[-1]
      if line
        real_gem_name = line.split(' ').first
        require 'yaml'
        yaml = `gem specification #{real_gem_name}`
        gem_spec = YAML::load( yaml )
        # If there's no lib/gem_name.rb in the files array of the gem spec
        unless gem_spec.ivars['files'].select { |f| f =~ /^lib\/#{gem_name}\.rb$/}.size == 1
          # Add a :require for the first lib/(.*).rb listed in gem spec files array
          load_files = gem_spec.ivars['files'].select { |f| f =~ /^lib\/([\w_\-]+)\.rb$/}
          if load_files && load_files.first =~ /lib\/(.*)\.rb/
            requirement = ", :require => '#{$1}'" if $1 != gem_name
          end
        end
        # TODO Suggest all the installed versions?
        "gem '#{gem_name}', '${1:#{gem_spec.ivars['version'].ivars['version']}}'#{requirement}"
      else
        "gem '#{gem_name}'"
      end
    else
      "gem"
    end
  end
end

snippet 'group' do |s|
  s.trigger = 'group'
  s.scope = 'source.ruby'
  s.expansion = 'group :${1:development} do
  $0
end'
end

snippet 'source' do |s|
  s.trigger = 'source'
  s.scope = 'source.ruby'
  s.expansion = 'source :${1:rubygems}'
end

snippet 'git' do |s|
  s.trigger = 'git'
  s.scope = 'source.ruby'
  s.expansion = 'git "${1:git://github.com/someuser/repo.git}", :tag => "${2:v1.0.0}"'
end