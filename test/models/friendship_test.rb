# require File.dirname(__FILE__) + '/../test_helper'
require 'test_helper'


class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :users

  def setup

  	@sender = users(:valid_sender)

  	@recipient = users(:recipient)
  end

  def test_request

  	Friendship.request(@sender, @recipient)

  	assert Friendship.exists?(@sender, @recipient)

  	assert_status @sender, @recipient, 'pending'

  	assert_status @recipient, @sender, 'requested'

  end

  def test_accept

  	Friendship.request(@sender, @recipient)

  	Friendship.accept(@sender, @recipient)

  	assert Friendship.exists?(@sender, @recipient)

  	assert_status @sender, @recipient, 'accepted'
  	assert_status @recipient, @sender, 'accepted'
  end

  def test_breakup
  	Friendship.request(@sender, @recipient)
  	Friendship.breakup(@sender, @recipient)
  	assert !Friendship.exists?(@sender, @recipient)
  end


  private
 # Verify the existence of a friendship with the given status.
 def assert_status(sender, recipient, status)
 	friendship = Friendship.find_by_sender_id_and_recipient_id(sender, recipient)
 	assert_equal status, friendship.status
 end



end
