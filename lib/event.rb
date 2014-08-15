class Event < ActiveRecord::Base
  validates :description, :presence => true
  #validates_date :start_date, :format

  def self.choose_event
    Event.all.each {|event| puts event.description}
    puts "Choose an event"
    event = Event.find_by(:description => gets.chomp)
  end

  scope :future_events, ->(date) { where("start_date > ?", date).order(:start_date) }

  scope :todays_events, ->(date) { where("start_date = ?", date).order(:start_date) }

  scope :weeks_events, ->(date) { where("start_date >= ? AND start_date <= ?",
        date, date+7.days).order(:start_date) }

  scope :months_events, ->(date) { where("start_date >= ? AND start_date <= ?",
        date, date+1.months) }

end
