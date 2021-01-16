class Friendship < ApplicationRecord

	belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
	belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

	validates_presence_of :sender_id, :recipient_id


	# Return true if the users are (possibly pending) friends.

	def self.exists?(sender, recipient)

		not Friendship.find_by(sender_id: sender, recipient_id: recipient).nil?

	end


	# Record a pending friend (recipient) request.

	def self.friend_request(sender, recipient)
		# sender = sender.id
		# unless sender == recipient or Friendship.exists?(sender, recipient)
		# 	Friendship.create(:sender_id => sender, :recipient_id => recipient, :status => 'pending')
		# end
		unless sender == recipient or Friendship.exists?(sender, recipient)

			transaction do
				create(:sender_id => sender, :recipient_id => recipient, :status => 'pending')
				create(:sender_id => recipient, :recipient_id => sender, :status => 'requested')
			end
		end
	end


	# Accept a friend request.

	def self.accept_request(sender, recipient)

		transaction do

			accept_one_side(sender, recipient)

			accept_one_side(recipient, sender)

		end

	end


	# Delete a friendship or cancel a pending request.

	def self.breakup(sender, recipient)

		transaction do

			destroy(find_by(sender_id: sender, recipient_id: recipient).id)

			destroy(find_by(sender_id: recipient, recipient_id: sender).id)

		end

	end

	private

	# Update the db with one side of an accepted friendship request.

	def self.accept_one_side(sender, recipient)

		friend_request = Friendship.find_by(sender_id: sender, recipient_id: recipient)

		friend_request.status = 'accepted'

		friend_request.save!

	end


end
