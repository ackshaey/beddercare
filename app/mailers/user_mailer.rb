class UserMailer < ActionMailer::Base
  default from: "beddercare@gmail.com"
  def notification_email(new_room)
  	@new_room = new_room
  	@user = User.find(@new_room.user_id)
  	id = @new_room.id.to_s
  	@url = "http://beddercare.herokuapp.com/party/#{id}"
  	mail(to: @user.email, subject: 'Beddercare : Video Chat Invitation')
  end
end
