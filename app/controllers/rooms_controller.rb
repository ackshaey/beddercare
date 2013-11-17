class RoomsController < ApplicationController

	API_KEY = '20321822'     # replace with your OpenTok API key
	API_SECRET = '6a06ade722c52e21764de05b5788b34619e55ca0'  # replace with your OpenTok API secret
	before_filter :config_opentok, :except => [:index]

	def index
		@rooms = Room.where(:public => true).order("created_at DESC")
		@new_room = Room.new
		@users = User.all
		# respond_to do |format|
		# format.html {redirect_to(root_path)}
		# end
	end

	def create
		if @opentok.nil? 
			raise "Error! @opentok object was nil"
		else
			@calledUser = User.find(params[:user_id])
			session = @opentok.create_session request.remote_addr
			@calledUser
			# params[:room][:sessionId] = session.session_id unless params[:room].nil?
			@new_room = Room.new()
			@new_room.user_id = params[:user_id]
			@new_room.sessionId = session.session_id
			new_room_id = @new_room.id.to_s
			UserMailer.notification_email(@calledUser, new_room_id).deliver
			respond_to do |format|
				if @new_room.save
					format.html {redirect_to("/party/"+@new_room.id.to_s)}
				else
					format.html {render :controller => 'rooms', :action => 'index'}
				end
			end
		end
	end

	def party
		@room = Room.find(params[:id])
		@token = @opentok.generate_token(:session_id => @room.sessionId)
	end

	private

	def config_opentok
		if @opentok.nil?
  		@opentok = OpenTok::OpenTokSDK.new API_KEY, API_SECRET
  	end

  	def room_params
  	  params.require(:room).permit!
  	end
  end
end
