class ApplicationMailer < ActionMailer::Base
  default from: app_config.noreply
  layout 'mailer'
end
