class CreateFeedback < ActiveRecord::Migration
  def self.up
    create_table :feedback do |t|
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :feedback
  end
end
