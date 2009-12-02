class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :message_id
      t.integer :recipient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
