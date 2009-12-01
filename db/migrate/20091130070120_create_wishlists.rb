class CreateWishlists < ActiveRecord::Migration
  def self.up
    create_table :wishlists do |t|
      t.integer :user_id
      t.string :name
      t.integer :item_count

      t.timestamps
    end
  end

  def self.down
    drop_table :wishlists
  end
end
