class CreateMailboxes < ActiveRecord::Migration
  def self.up
    create_table :mailboxes do |t|
      t.integer :user_id
      t.string :name
      t.integer :messages_count, :default => 0

      t.timestamps
    end
    add_column :users, :inbox_id, :integer
    add_column :users, :sent_id, :integer
    add_column :users, :archive_id, :integer

    # add an inbox, archive, and sent mailbox for each user
    User.reset_column_information
    User.find(:all).each do |user|
      user.inbox = user.mailboxes.create(:name => 'inbox')
      user.sent = user.mailboxes.create(:name => 'sent')
      user.archive = user.mailboxes.create(:name => 'archive')
      user.save
    end
  end

  def self.down
    remove_column :users, :inbox_id
    remove_column :users, :sent_id
    remove_column :users, :archive_id
    drop_table :mailboxes
  end
end
