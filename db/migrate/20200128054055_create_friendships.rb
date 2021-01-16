class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.bigint :sender_id
      t.bigint :recipient_id
      t.string :status

      t.timestamps
    end
  end
end
