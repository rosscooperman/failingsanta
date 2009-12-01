class AddBuyerIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :buyer_id, :integer
  end

  def self.down
    remove_column :items, :buyer_id
  end
end
