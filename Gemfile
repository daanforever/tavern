source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'autoprefixer-rails'              # Autoprefixer for Ruby and Ruby on Rails
gem 'bootstrap-sass'                  # Official Sass port of Bootstrap
gem 'angularjs-rails'                 # A simple Angular.js wrapper for Rails

gem 'devise'                          # Flexible authentication solution for Rails with Warden

gem 'haml'                            # HTML Abstraction Markup Language
gem 'responders'                      # A set of Rails responders to dry up your application
gem 'has_scope'                       # Maps controller filters to your resource scopes
# gem 'simple_form', github: 'plataformatec/simple_form' # Forms made easy for Rails!
gem 'simple_form'                     # Forms made easy for Rails!
gem 'kaminari'                        # Customizable and sophisticated paginator
gem 'kaminari-bootstrap'              # Integrates with Twitter Bootstrap

gem 'guid'                            # Produce GUID/UUID from Ruby
gem 'aasm'                            # State machines for Ruby classes

gem 'thin'                            # Web server. Usage: rails s thin
gem 'seed_dump'                       # Rails plugin to create seed data
gem 'awesome_print'                   # For rails console

gem 'docker_registry'                 # Docker registry HTTP API client
gem 'docker-api', '~> 1.15.0', require: 'docker' # Provides an object-oriented interface to the Docker Remote API

gem 'delayed_job_active_record'       # Database based asynchronous priority queue system
gem 'delayed_job_recurring'           # Extends delayed_job to support recurring jobs
gem 'settingson'                      # Settings management
gem 'foreman'                         # Manage Procfile-based applications

group :doc do
  gem 'sdoc'                          # bundle exec rake doc:rails generates the API under doc/api.
end

group :production do
  gem 'pg'                            # Use postgresql as the database for Active Record
end

group :development, :test do
  gem 'sqlite3'                       # Use sqlite3 as the database for Active Record
  gem 'spring'                        # Spring speeds up development
  gem 'spring-commands-rspec'         # Implements the rspec command for Spring
  gem 'better_errors'                 # Better errors handler
  gem 'binding_of_caller'             # For better_errors
  gem 'meta_request'                  # For RailsPanel (chrome extention)
  gem 'rack-mini-profiler'            # Rails profiler
  gem 'brakeman'                      # Security scanner. Usage: brakeman [-o file.html]
  gem 'bullet'                        # Query optimization # TODO need to configure
  gem 'annotate'                      # Annotate ActiveRecord models. Usage: annotate
  gem 'haml-rails'                    # Integration for HAML
  gem 'railroady'                     # Class diagram generator. Usage: rake diagram:all
end

group :test do
  gem "rspec-rails"                       # Test suite
  gem 'factory_girl_rails'                # Fixtures replacement
  gem 'database_cleaner'                  # Helper gem for rspec
  gem 'shoulda-matchers', require: false  # Rspec-compatible one-liners
  gem 'faker'                             # A library for generating fake data
  gem 'simplecov', require: false         # Code coverage
  gem 'coveralls', require: false         # A Ruby implementation of the Coveralls API
  gem 'webmock'                           # Library for stubbing and setting expectations on HTTP requests
  gem "codeclimate-test-reporter", require: nil # Code Climate
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

