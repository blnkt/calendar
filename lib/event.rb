class Event < ActiveRecord::Base

  def self.future_events
    Event.all.where(start_date: Time.now.strftime('%Y-%m-%d %H:%M')..(Time.now + 5.year).strftime('%Y-%m-%d %H:%M'))
  end
end

# t.strftime('%Y-%m-%d %H:%M')
# (created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
