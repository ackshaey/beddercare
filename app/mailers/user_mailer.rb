class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(new_room)
  	@room = new_room
  	@user = User.find(@room.user_id)
  	id = @room.id.to_s
  	@url = "http://beddercare.herokuapp.com/party/#{id}"
  	mail(to: @user.email, subject: 'Beddercare : Video Chat Invitation')
  end
end
