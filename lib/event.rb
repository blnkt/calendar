class Event < ActiveRecord::Base

  @current_day = Time.new

  def self.future_events
    Event.all.where("? < end_date AND ? > end_date", Time.now.strftime('%Y-%m-%d %H:%M'), (Time.now + 1.year).strftime('%Y-%m-%d %H:%M'))
  end

  def self.by_date date
    y = date.split('-')[0].to_i
    m = date.split('-')[1].to_i
    d = date.split('-')[2].to_i
    date_time = Time.new(y, m, d)
    @current_day = date_time
    Event.all.where("start_date <= ? AND end_date >= ?", date, date)
  end

  def self.by_week date
    y = date.split('-')[0].to_i
    m = date.split('-')[1].to_i
    d = date.split('-')[2].to_i
    date_time = Time.new(y, m, d)
    @current_day = date_time
    previous_sunday = date_time - date_time.wday.day
    next_sunday = previous_sunday + 1.week
    Event.all.where.not("start_date < ? AND end_date < ? OR start_date > ? AND end_date > ?", previous_sunday, previous_sunday, next_sunday, next_sunday)
  end

  def self.by_month date
    y = date.split('-')[0].to_i
    m = date.split('-')[1].to_i
    d = date.split('-')[2].to_i
    date_time = Time.new(y, m, d)
    @current_day = date_time
    first = Time.new(y, m, 1)
    last = Time.new(y, m+1, 1) - 1.day
    Event.all.where.not("start_date < ? AND end_date < ? OR start_date > ? AND end_date > ?", first, first, last, last)
  end

  def self.next_month
    Event.by_month((@current_day + 1.month).strftime('%Y-%m-%d %H:%M'))
  end

end
