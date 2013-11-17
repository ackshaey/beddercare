class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(user,room)
  	@user = user
  	@url = "http://beddercare.herokuapp.com/party/"+room.id.to_s
  	mail(to: "ackshaey@gmail.com", subject: 'Beddercare : Video Chat Invitation')
  end
end
