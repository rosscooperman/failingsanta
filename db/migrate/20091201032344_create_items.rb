class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :wishlist_id
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end

    add_column :users, :items_count, :integer, :default => 0
  end

  def self.down
    drop_table :items
    remove_column :users, :items_count
  end
end
