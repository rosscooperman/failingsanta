class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_many :receipts
  has_many :recipients, :through => :receipts do
    def to_s
      names = find(:all, :select => 'name').map { |r| r.name }
      names.join ', '
    end
  end

  def format_reply
    reply = body.gsub(/<br\s*\/?>/, "\n")
    reply.gsub!(/^<p>/, '')
    reply.gsub!(/<\/p>$/, '')
    lines = reply.split(/\n/).map do |line|
      if line.blank? || line.start_with?("&gt;") || line.start_with?(">")
        "> " + line
      else
        line.gsub(/(.{1,80}\w*)\s*/, "> \\1\n")
      end
    end
    reply = lines.join("\n").gsub(/\n\n/, "\n")

    "\n\n\non #{created_at.to_s(:withtime)}, #{sender.name} wrote:\n\n" + reply
  end
end
