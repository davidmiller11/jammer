# user_mailer.rb
# in mailers, like a controller
class UserMailer < ActionMailer::Base
  default from: "jammersquad@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome to Jammer!')
  end

  def invite_email(jam, user_id)
    @user = User.find(user_id)
    @jam = jam
    @url = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'New Jam Request!')
  end
end
