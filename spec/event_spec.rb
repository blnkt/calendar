require 'spec_helper'

describe 'Event' do
  it 'initialize with a description, location, or dates' do
    new_event = Event.create({description: 'Tech-crawl'})
    expect(new_event).to be_a Event
  end

  it 'edit an event' do
    new_event = Event.create({description: 'Tech-crawl'})
    new_event.update(location: "Barbados")
    expect(new_event.location).to eq "Barbados"
  end

  it 'delete an event' do
    new_event = Event.create({description: 'Tech-crawl'})
    new_event.destroy
    expect(Event.all).to eq []
  end

  describe '.future_events' do
    it 'lists all events with end_date in the future' do
      event1 = Event.create({description: 'Tech-crawl', start_date: '2014-08-10 20:00', end_date: '2014-08-16 20:00'})
      event2 = Event.create({description: 'MFNW', end_date: '2014-08-15'})
      event3 = Event.create({description: 'PDXPop', end_date: '2014-06-12 12:00'})
      expect(Event.future_events).to eq [event1, event2]
    end
  end

  describe '.by_day' do
    it 'lists all events on a given date' do
      event1 = Event.create({description: 'Tech-crawl', start_date: '2014-08-10 20:00', end_date: '2014-08-16 20:00'})
      event2 = Event.create({description: 'MFNW', start_date: '2014-08-15', end_date: '2014-08-15'})
      expect(Event.by_day('2014-8-12')).to eq [event1]
    end
  end

  describe '.by_week' do
    it 'lists all events within a week' do
      before_before = Event.create({description: 'PDXPop', start_date: '2014-08-01', end_date: '2014-08-02 12:00'})
      before_during = Event.create({description: 'MFNW', start_date: '2014-08-09', end_date: '2014-08-13'})
      during_during = Event.create({description: 'Tech-crawl', start_date: '2014-08-12 20:00', end_date: '2014-08-15 20:00'})
      during_after = Event.create({description: 'PDXPop', start_date: '2014-08-15', end_date: '2014-08-23 12:00'})
      after_after = Event.create({description: 'PDXPop', start_date: '2014-08-20', end_date: '2014-08-23 12:00'})
      before_after = Event.create({description: 'PDXPop', start_date: '2014-08-06', end_date: '2014-08-23 12:00'})
      expect(Event.by_week('2014-8-12')).to eq [before_during, during_during, during_after, before_after] #8/10 - 8/17
    end
  end

  describe '.by_month' do
    it 'lists all events within a month' do
      before_before = Event.create({description: 'PDXPop', start_date: '2014-07-01', end_date: '2014-07-02 12:00'})
      before_during = Event.create({description: 'MFNW', start_date: '2014-07-09', end_date: '2014-08-13'})
      during_during = Event.create({description: 'Tech-crawl', start_date: '2014-08-12 20:00', end_date: '2014-08-31 20:00'})
      during_after = Event.create({description: 'PDXPop', start_date: '2014-08-15', end_date: '2014-09-01 12:00'})
      after_after = Event.create({description: 'PDXPop', start_date: '2014-09-20', end_date: '2014-09-23 12:00'})
      before_after = Event.create({description: 'PDXPop', start_date: '2014-07-06', end_date: '2014-09-23 12:00'})
      expect(Event.by_month('2014-8-12')).to eq [before_during, during_during, during_after, before_after] #8/01 - 8/31
    end
  end

  describe '.next_month' do
    it 'lists all events within the next month' do
      before_before = Event.create({description: 'PDXPop', start_date: '2014-07-01', end_date: '2014-07-02 12:00'})
      before_during = Event.create({description: 'MFNW', start_date: '2014-07-09', end_date: '2014-08-13'})
      during_during = Event.create({description: 'Tech-crawl', start_date: '2014-08-12 20:00', end_date: '2014-08-31 20:00'})
      during_after = Event.create({description: 'PDXPop', start_date: '2014-08-15', end_date: '2014-09-01 12:00'})
      after_after = Event.create({description: 'PDXPop', start_date: '2014-09-20', end_date: '2014-09-23 12:00'})
      before_after = Event.create({description: 'PDXPop', start_date: '2014-07-06', end_date: '2014-09-23 12:00'})
      Event.by_month('2014-8-12')
      expect(Event.next_month).to eq [during_after, after_after, before_after] #9/01 - 9/31
    end
  end

  describe '.next_week' do
    it 'lists all events within the next week' do
      before_before = Event.create({description: 'PDXPop', start_date: '2014-08-01', end_date: '2014-08-02 12:00'})
      before_during = Event.create({description: 'MFNW', start_date: '2014-08-09', end_date: '2014-08-13'})
      during_during = Event.create({description: 'Tech-crawl', start_date: '2014-08-12 20:00', end_date: '2014-08-15 20:00'})
      during_after = Event.create({description: 'PDXPop', start_date: '2014-08-15', end_date: '2014-08-23 12:00'})
      after_after = Event.create({description: 'PDXPop', start_date: '2014-08-20', end_date: '2014-08-21 12:00'})
      before_after = Event.create({description: 'PDXPop', start_date: '2014-08-06', end_date: '2014-08-21 12:00'})
      Event.by_week('2014-8-12')
      expect(Event.next_week).to eq [during_after, after_after, before_after] #8/17 - 8/23
    end
  end

  describe '.next_day' do
    it 'lists all events tomorrow' do
      before_after = Event.create({description: 'Tech-crawl', start_date: '2014-08-10 20:00', end_date: '2014-08-16 20:00'})
      after_after = Event.create({description: 'MFNW', start_date: '2014-08-15', end_date: '2014-08-17'})
      during_after = Event.create({description: 'other', start_date: '2014-08-13 20:00', end_date: '2014-08-16 20:00'})
      Event.by_day('2014-8-12')
      expect(Event.next_day).to eq [before_after, during_after] #8/13
    end
  end
end
