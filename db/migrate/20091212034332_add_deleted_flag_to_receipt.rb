class AddDeletedFlagToReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :deleted, :boolean, :default => false
  end

  def self.down
    remove_column :receipts, :deleted
  end
end
