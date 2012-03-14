class UserMailer < ActionMailer::Base
  default from: "#{Config["company"]["name"]} <#{Config["company"]["email"]}>"
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "#{Config["company"]["name"]}: Password Reset"
  end
  
  def welcome(user, generated_password)
    @user = user
    @generated_password = generated_password
    mail to: user.email, subject: "#{Config["company"]["name"]}: Welcome"
  end
end
