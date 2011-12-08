source "http://rubygems.org"

gem "rails", "3.1.3"
gem "jquery-rails"
gem "authlogic"
gem "newrelic_rpm"
gem "exceptional"
gem "sanitize"
gem "capistrano"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails",   "~> 3.1.5"
  gem "coffee-rails", "~> 3.1.1"
  gem "uglifier", ">= 1.0.3"
end

group :test do
  gem "turn", "~> 0.8.3", :require => false
end

group :development do
  gem "letter_opener"
  gem "annotate", "2.4.1.beta1"
end

group :development, :test do
  gem "sqlite3"
end

group :production do
  gem "mysql"
  gem "therubyracer"
end
