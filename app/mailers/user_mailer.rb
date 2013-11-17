class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(user,room)
  	@user = user
  	@room = room
  	@url = "http://beddercare.herokuapp.com/party/"+@room.id.to_s
  	mail(to: "ackshaey@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
