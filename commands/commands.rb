require 'ruble'

with_defaults :scope => 'source.ruby', :output => :discard, :input => :none do
  commands = ['package', 'install', 'check', 'update', 'init', 'list']
  commands.each do |name|
    command(name) {|c| c.invoke { Ruble::Terminal.open("bundle #{name}") } }
  end
end