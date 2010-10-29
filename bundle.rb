require 'ruble'

bundle 'Bundler' do |bundle|
  bundle.author = 'Dr Nic Williams'
  bundle.contact_email_rot_13 = 'qeavpjvyyvnzf@tznvy.pbz'
  bundle.description = "Helpers for managing Gemfiles and bundler commands."

  bundle.menu 'Bundler' do |main_menu|
    main_menu.command 'init'
    main_menu.command 'check'
    main_menu.command 'package'
    main_menu.command 'install'
    main_menu.command 'update'
    main_menu.command 'list'
    main_menu.separator
    main_menu.command 'gem'
    main_menu.command 'group'
  end
end