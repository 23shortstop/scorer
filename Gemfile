source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'

#https://github.com/errbit/errbit for errors

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rack-timeout'
gem 'draper'
gem 'active_model_serializers'
gem 'oj'
gem 'kaminari'
gem 'dci', github: 'techery/dci'
gem 'puma'
gem 'rubocop', require: false
gem 'redis'
gem 'versionist'
gem 'carrierwave'
gem 'token_auth', git: 'https://git.yalantis.com/roman.tomilin/rails-token-auth.git'

group :development do
  gem 'foreman'
  #gem 'spring'
  #gem 'spring-commands-rspec'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-collection_matchers'
  gem 'rspec_api_documentation'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 2.8.0', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
