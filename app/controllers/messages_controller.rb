class MessagesController < ApplicationController
	before_action do 
		@conversation = Conversation.find(params[:conversation_id])
	end



	def index
		@messages = @conversation.messages
		@message = @conversation.messages.new
	end

	def new 
		@message = @conversation.messages.new
	end

	def create
		@message = @conversation.messages.new(message_params)
		if @message.save
			# sender_dp = User.find(@message.user_id).profile_image
			# user = User.find(@message.user_id)
			user = User.find(@message.user_id)
			# sender_dp =  image_tag user_avatar(user, 20), class: "rounded-circle", style: "margin-right: 5px;"
			sender_name = user.name
			ActionCable.server.broadcast 'room_channel', body: {body: @message.body, sender_name: sender_name.split(" ")[0]}
			redirect_to conversation_messages_path(@conversation)
		end
	end

	private
	def message_params
		params.require(:message).permit(:body, :user_id)
	end
end