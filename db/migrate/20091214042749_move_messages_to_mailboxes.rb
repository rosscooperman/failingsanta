class MoveMessagesToMailboxes < ActiveRecord::Migration
  def self.up
    add_column :messages, :to, :string
    add_column :messages, :mailbox_id, :integer

    Message.reset_column_information
    Message.all.each do |message|
      newmsg = message.clone
      newmsg.to = message.recipients.map{ |r| r.login }.join(',')
      message.sender.sent.messages << newmsg
      message.receipts.each do |r|
        if r.recipient.nil?
          r.destroy
        elsif r.deleted?
          r.recipient.archive.messages << newmsg.clone
        else
          r.recipient.inbox.messages << newmsg.clone
        end
      end
    end
  end

  def self.down
    User.reset_column_information
    User.all.each do |user|
      user.inbox.messages.clear
      user.sent.messages.clear
      user.archive.messages.clear
    end

    remove_column :messages, :to
    remove_column :messages, :mailbox_id
  end
end
