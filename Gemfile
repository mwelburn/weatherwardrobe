source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


gem 'devise', '1.4.5'
gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git' , :tag => 'v0.3.0.rc3'
gem 'oa-oauth', :require => 'omniauth/oauth'

group :development do
  gem 'sqlite3'
  gem 'nifty-generators'
  gem 'ruby-debug19', :require => 'ruby-debug'

  gem 'rspec'
  gem 'rspec-rails'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'

  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'heroku'
  gem 'pg' #postgreSQL for heroku
end