source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '>= 5.0.1', '< 5.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.2',          group: :doc
gem 'puma', '~> 3.0'
gem 'turbolinks', '~> 5.0'
gem 'jquery-rails'

gem 'rake'
gem 'simple_form'
gem 'nokogiri'
gem 'seedbank'
gem 'sorcery'
gem 'faraday'
gem 'figaro'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'rails_12factor', group: :production
gem 'levenshtein'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'routing-filter'
gem 'rollbar'
gem 'rainbow', '>= 2.1.0', '< 2.2.0'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem 'rolify'
gem 'pundit'
gem 'flickraw'
gem 'webmock'

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'brakeman', :require => false
  gem 'rubocop', '~> 0.47.1', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'simplecov'
  gem 'pundit-matchers', '~> 1.1.0'
end

group :development, :test do
  gem 'capybara', '~> 2.11'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'codeclimate-test-reporter', '~> 1.0.0'

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
