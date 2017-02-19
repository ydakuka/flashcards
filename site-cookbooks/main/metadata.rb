name 'main'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures main'
long_description 'Installs/Configures main'
version '0.1.0'

supports 'centos'

recipe 'default', 'Default recipe'

%w{sudo apt build-essential chef_gem gpg curl ssh_known_hosts runit postgresql
   ruby_rbenv user ruby_build application application_ruby poise-ruby}.each do |cb|
  depends cb
end
