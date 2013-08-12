source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'cancan'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'rolify'
gem 'simple_form', '>= 3.0.0.rc'
gem 'slim'
gem 'omniauth-mygov', :git => 'https://github.com/GSA-OCSIT/omniauth-mygov.git' # :path => '~/code/gems/omniauth-myusa'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
  gem 'pry'
  gem 'pry-nav'
  gem 'zeus'
end
group :production do
  gem 'unicorn'
  gem 'pg'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'simplecov', :require => false
end
