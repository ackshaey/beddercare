class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(user,room_id)
  	@user = user
  	@url = "http://beddercare.herokuapp.com/party/#{room_id}"
  	mail(to: @user.email, subject: 'Beddercare : Video Chat Invitation')
  end
end
