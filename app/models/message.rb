class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_many :receipts
  has_many :recipients, :through => :receipts do
    def to_s
      names = find(:all, :select => 'name').map { |r| r.name }
      names.join ', '
    end
  end
end
