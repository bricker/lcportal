class UserMailer < ActionMailer::Base
  default from: "#{AppConfig["company"]["name"]} <#{AppConfig["company"]["email"]}>"
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "#{AppConfig["company"]["name"]}: Password Reset"
  end
  
  def welcome(user, generated_password)
    @user = user
    @generated_password = generated_password
    mail to: user.email, subject: "#{AppConfig["company"]["name"]}: Welcome"
  end
end
