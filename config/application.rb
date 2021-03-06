require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kindergarten
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ru
    
    # Default e-mail address which will be shown in the "from" devise emails, initializers/devise.rb,
    config.noreply = 'noreply@журавлик15.рф'
    
    config.mail_to = 'ivfefilov@gmail.com'
        
    # Default host for action mailer, initializers/mailer.rb
    config.host = 'журавлик15.рф'
    config.active_job.queue_adapter = :delayed_job
  end
end
