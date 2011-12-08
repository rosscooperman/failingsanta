class AddGifteeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :giftee_id, :integer
  end
end
