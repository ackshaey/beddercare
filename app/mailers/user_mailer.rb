class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(user,room)
  	@user = user
  	@room = room
  	mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
