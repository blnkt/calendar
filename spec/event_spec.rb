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
    it 'lists all events in the future' do
      event1 = Event.create({description: 'Tech-crawl', start_date: '2014-08-14 20:00'})
      event2 = Event.create({description: 'MFNW', start_date: '2014-08-15'})
      event3 = Event.create({description: 'PDXPop', start_date: '2014-06-12 12:00'})
      p Event.future_events
      expect(Event.future_events).to eq [event1, event2]
    end
  end
end
