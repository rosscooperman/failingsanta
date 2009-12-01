class WowItemsCountIsOnTheWrongTable < ActiveRecord::Migration
  def self.up
    remove_column :users, :items_count
    add_column :wishlists, :items_count, :integer, :default => 0
  end

  def self.down
    remove_column :wishlists, :items_count
    add_column :users, :items_count, :integer, :default => 0
  end
end
