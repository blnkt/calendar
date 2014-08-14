class Event < ActiveRecord::Base

  def self.future_events
    # Event.all.where(end_date: Time.now.strftime('%Y-%m-%d %H:%M')..(Time.now + 1.year).strftime('%Y-%m-%d %H:%M'))
    Event.all.where("? < end_date AND ? > end_date", Time.now.strftime('%Y-%m-%d %H:%M'), (Time.now + 1.year).strftime('%Y-%m-%d %H:%M'))
  end

  def self.by_date date
    Event.all.where("start_date <= ? AND end_date >= ?", date, date)
  end

  def self.by_week date
    y = date.split('-')[0].to_i
    m = date.split('-')[1].to_i
    d = date.split('-')[2].to_i
    date_time = Time.new(y, m, d)
    previous_sunday = date_time - date_time.wday.day

    next_sunday = previous_sunday + 1.week
    Event.all.where("start_date <= ? AND end_date >= ? OR start_date <= ? AND end_date >= ?", previous_sunday, previous_sunday, next_sunday, previous_sunday)
  end

  def self.by_month date

  end
end

# t.strftime('%Y-%m-%d %H:%M')
# (created_at: (Time.now.midnight - 1.day)..Time.now.midnight)

# end_date: date.strftime('%Y-%m-%d')..date.date.strftime('%Y-%m-%d 23:59:59')
# or (start_date: date.strftime('%Y-%m-%d')..date.date.strftime('%Y-%m-%d 23:59:59')
