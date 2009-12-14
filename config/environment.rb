# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem 'authlogic',    :version => '>=2.1'
  config.gem "newrelic_rpm", :version => '>=2.9'
  config.gem 'exceptional',  :version => '>=2.0'

  # Other settings
  config.time_zone = 'Eastern Time (US & Canada)'
  config.action_mailer.default_content_type = 'text/html'
  config.action_view.sanitized_allowed_attributes = 'style'
  config.action_mailer.default_url_options = { :host => "www.failingsanta.com" }
end

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :default  => '%D',
  :withtime => '%D at %r'
)