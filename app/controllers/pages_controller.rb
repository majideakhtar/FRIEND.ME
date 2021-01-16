class PagesController < ApplicationController
	before_action :authenticate_user!


	def index
		@friendships = Friendship.all.where(sender_id: current_user.id)
		@users = User.all		
		if params[:search].present?
			@users = User.where("name LIKE '%#{params[:search]}%'")
		else
			@users = User.all		
		end
	end


	def home
		@friendships = Friendship.all.where(sender_id: current_user.id, status: "accepted")
		@users = User.all	
		@friend_requests = @friendships.where(status: "requested")
	end


	def new
		@user = User.find(params[:id])
	end


	def send_request
		sender_id = current_user.id
		recipient_id = User.find(params[:id]).id
		Friendship.friend_request(sender_id, recipient_id)
		redirect_to root_path
	end


	def show
		@friendships = Friendship.all.where(sender_id: current_user.id)

		@user = User.find(params[:id])
	end



end
