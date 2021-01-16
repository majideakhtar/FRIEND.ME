class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def index
		@friendships = Friendship.all
		@users = User.all
		# @conversations = Conversation.all
		


	end
	def approve_request
		
		sender_id = params[:recipient_id].to_i
		recipient_id = current_user.id
		Friendship.accept_request(sender_id, recipient_id)
		redirect_to friendships_path
	end

	def unfriend_request
		
		sender_id = params[:recipient_id].to_i
		recipient_id = current_user.id
		Friendship.breakup(sender_id, recipient_id)
		redirect_to friendships_path
	end

	def show
		# binding.pry
		@friendship = Friendship.find(params[:id])
      redirect_to friendships_path
	end

	def new
		@friendship = Friendship.new
	end
	
	def create
		# @friendship = Friendship.new

	end
	
	# def edit
	# 	@friendship = Friendship.find(params[:id])
	# end

	# def update
	# 	@friendship = Friendship.find(params[:id])
	# end

	def chat
		sender_id = current_user.id
		recipient_id = params[:recipient_id].to_i
		Conversation.create(sender_id, recipient_id)
		redirect_to root_path
	end
	
end