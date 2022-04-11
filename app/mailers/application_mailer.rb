# frozen_string_literal: true

# base mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@sebs-rails.com'
  layout 'mailer'
end
