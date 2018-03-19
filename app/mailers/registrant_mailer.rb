class RegistrantMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def registration_email(registrant)
    @registrant = registrant
    @url  = 'http://example.com/login'
    mail(to: @registrant.email, subject: 'Welcome to My Awesome Site')
  end
end
