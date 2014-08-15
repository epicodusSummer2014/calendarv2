require 'spec_helper'


describe "Event" do
  it "creates an event with a description and stuff" do
    event = Event.create(:description => "party", :location => "guy's house", :start_date => "2014-08-15", :end_date =>"2014-09-15")
    expect(event).to be_a Event
  end

  it "returns future events in order by date" do
    event = Event.create(:description => "party", :location => "guy's house", :start_date => "2014-08-19", :end_date =>"2014-09-15")
    event2 = Event.create(:description => "funeral", :location => "guy's house", :start_date => "2014-08-11", :end_date =>"2014-09-15")
    event3 = Event.create(:description => "derf's party", :location => "guy's house", :start_date => "2014-08-16", :end_date =>"2014-09-15")
    expect(Event.future_events(Date.today)).to eq [event3, event]
  end

  it 'returns all events on the current day' do
    event = Event.create(:description => "party", :location => "guy's house", :start_date => "2014-08-15", :end_date =>"2014-09-15")
    event2 = Event.create(:description => "funeral", :location => "guy's house", :start_date => "2014-08-16", :end_date =>"2014-09-15")
    expect(Event.todays_events(Date.today)).to eq [event]
  end

  it 'returns all events for the current week' do
    event = Event.create(:description => "party", :location => "guy's house", :start_date => "2014-08-15", :end_date =>"2014-09-15")
    event2 = Event.create(:description => "funeral", :location => "guy's house", :start_date => "2014-08-31", :end_date =>"2014-09-15")
    expect(Event.weeks_events(Date.today)).to eq [event]
  end

   it 'returns all events for the current month' do
    event = Event.create(:description => "party", :location => "guy's house", :start_date => "2014-08-15", :end_date =>"2014-09-15")
    event2 = Event.create(:description => "funeral", :location => "guy's house", :start_date => "2014-09-31", :end_date =>"2014-09-15")
    expect(Event.months_events(Date.today)).to eq [event]
  end



end
