
# Cookbook:: main
# Recipe:: default

# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'build-essential'
include_recipe 'ruby_build'
include_recipe 'runit'
include_recipe 'poise-ruby'

# OS Dependencies
%w(git postgresql-libs
   postgresql-devel epel-release libyaml-devel libffi-devel readline-devel
   zlib-devel).each do |pkg|
  package pkg
end

# latest supported version of ruby 2.3.1 for centos, lol
# ruby_build_ruby 'latest'

ruby_build_ruby '2.3.1' do
  prefix_path '/usr/local'
  action :install
end

link '/usr/bin/ruby' do
  to "/usr/local/bin/ruby"
end

gem_package 'bundler' do
  gem_binary '/usr/local/bin/gem'
  options '--no-ri --no-rdoc'
end

application '/vagrant' do
  owner 'vagrant'
  group 'vagrant'

  ruby_runtime 'ruby' do
    provider :chef
    version '2.3.1'
  end

  bundle_install do
    # user 'vagrant'
    # deployment false
    # without 'production'
    deployment true
    without %w{development test}
  end
  rails do
    database do
      adapter 'postgresql'
      database 'flashcards'
      host 'localhost'
      port 5432
      username 'postgres'
      password 'password'
    end
    precompile_assets false
    migrate true
    rails_env 'development'
  end
  ruby_execute 'rails s -b 0.0.0.0 -d'
end
