class AddNewToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :new, :boolean, :default => false
  end

  def self.down
    remove_column :messages, :new
  end
end
