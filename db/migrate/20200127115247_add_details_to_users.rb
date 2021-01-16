class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :name, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :boolean
    add_column :users, :mobile, :bigint, unique: true
    add_column :users, :likes, :text
    add_column :users, :dislikes, :text
    add_column :users, :city, :string
  end
end
