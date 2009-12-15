class Message < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  belongs_to :sender, :class_name => 'User'
  belongs_to :mailbox, :counter_cache => true

  def recipient_names
    User.find_all_by_login(to.split(',')).map{ |u| u.name }.join(', ')
  end

  def format_reply
    "<p></p><p>on #{created_at.to_s(:withtime)}, #{sender.name}" +
    " wrote:</p><blockquote>#{body}</blockquote>"
  end

  def index_date
    if created_at.today?
      hour = (created_at.hour % 12 == 0) ? 12 : created_at.hour % 12
      hour.to_s + created_at.strftime(":%M %p").downcase
    elsif created_at > DateTime.current.beginning_of_year
      created_at.strftime("%b ") + created_at.day.to_s
    else
      created_at.to_s
    end
  end

  def summary(limit)
    # if the subject alone is longer than (or equal to) the limit
    return subject[0...(limit - 3)] + '...' if subject.size > limit
    return subject if subject.size == limit

    body_clean = Sanitize.clean(body)
    body_count = limit - subject.size - 3
    body_snippet = (body_clean.size < body_count) ? body_clean : body_clean[0...body_count] + '...'
    "#{subject} <span class=\"subtext\">&ndash; #{body_snippet}</span>"
  end
end
