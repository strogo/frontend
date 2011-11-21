source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'mustache'

gem 'rack', '1.3.5'
gem 'rake', '0.9.2'

gem 'plek', :git => 'git@github.com:alphagov/plek.git'

if ENV['GOVSPEAK_DEV']
  gem 'govspeak', :path => '../govspeak'
else
  gem 'govspeak', '0.8.4'
end

if ENV['SLIMMER_DEV']
  gem 'slimmer', :path => '../slimmer'
else
  gem 'slimmer', '0.8.0'
end

if ENV['GEO_DEV']
  gem 'rack-geo', :path => '../rack-geo'
  gem 'geogov', :path => '../geogov'
else
  gem 'rack-geo', :git => 'git@github.com:alphagov/rack-geo.git'
  gem 'geogov', :git => 'git@github.com:alphagov/geogov.git'
end

if ENV['CDN_DEV']
  gem 'cdn_helpers', :path => '../cdn_helpers'
else
  gem 'cdn_helpers', '0.9'
end

gem "addressable"
gem 'exception_notification', '~> 2.4.1', :require => 'exception_notifier'

group :test do
  gem "mocha"
  gem "webmock", :require => false
  gem "ZenTest"
  gem "autotest-rails"
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
  gem 'test-unit'
end
