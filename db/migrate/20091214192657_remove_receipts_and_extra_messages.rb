class RemoveReceiptsAndExtraMessages < ActiveRecord::Migration
  def self.up
    drop_table :receipts
    Message.reset_column_information
    Message.delete_all(:mailbox_id => nil)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
