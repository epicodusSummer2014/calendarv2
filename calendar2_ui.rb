require 'active_record'
require './lib/event'
require 'textacular'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)
ActiveRecord::Base.extend(Textacular)

def menu
  choice = nil
  until choice == 'x'
    puts "CALENDAR"
    puts "Press 'a' to add an event"
    puts "Press 'e' to edit an event's details"
    puts "Press 'd' to delete an event"
    puts "Press 'f' to view all future events"
    puts "Press 't' to view today's events"
    puts "Press 'w' to view this week's events"
    puts "Press 'm' to view this month's events"
    puts "Press 'n' to view tomorrow's events"
    puts "Press 'nw' to view next week's events"
    puts "Press 'nm' to view next month's events"
    puts "Press 's' to search through your events"
    choice = gets.chomp
    case choice
    when 'a'
      add_event
    when 'e'
      edit_event
    when 'd'
      delete_event
    when 'f'
      future_events
    when 't'
      todays_events
    when 'w'
      weeks_events
    when 'm'
      months_events
    when 'n'
      next_day
    when 'nw'
      next_week
    when 'nm'
      next_month
    when 's'
      search_events
    when 'x'
      puts "Good-bye"
    else
      puts "Get outta town"
    end
  end
end


def add_event
  puts "What is the event description?"; description = gets.chomp
  puts "What is the location?" ; location = gets.chomp
  puts "Whats is the start date?" ; start_date = gets.chomp
  puts "what is the start time?" ; start_time = gets.chomp
  puts "What is the end date?" ; end_date = gets.chomp
  puts "What is the end time?" ; end_time = gets.chomp
  event = Event.create(:description => description, :location => location, :start_date => start_date, :end_date => end_date, :start_time => start_time, :end_time => end_time)
  puts "#{description} added to the books!"
end

def edit_event
  event = Event.choose_event
  puts "Would you like to edit the description, location, start_date, end_date, start_time or end_time?"
  input = gets.chomp
  puts "What is the new #{input}?"
  event.update(input.to_sym => gets.chomp)
  puts "#{input} updated!"
end

def delete_event
  event = Event.choose_event
  event.delete
  puts "#{event.description} deleted!"
end

def future_events
  puts "Here are all the upcoming events:"
  Event.future_events(Date.today).each { |event| puts event.description }
end

def todays_events
  puts "Here are all today's events:"
  Event.todays_events(Date.today).each { |event| puts event.description }
end

def weeks_events
  puts "Here are all the week's events"
  Event.weeks_events(Date.today).each { |event| puts event.description }
end

def months_events
  puts "Here are all the month's events"
  Event.months_events(Date.today).each { |event| puts event.description }
end

def next_day
  current_date = Date.today+1.days
  choice = nil
  while choice != 'n'
    Event.todays_events(current_date).each { |event| puts event.description}
    puts "would you like another?"
    choice = gets.chomp
      if choice == 'y'
        current_date += 1.days
      end
  end
end

def next_week
  current_date = Date.today+7.days
  choice = nil
  while choice != 'n'
    Event.weeks_events(current_date).each { |event| puts event.description }
    puts "would you like another?"
    choice = gets.chomp
      if choice == 'y'
        current_date += 7.days
      end
  end
end

def next_month
  current_date = Date.today+1.months
  choice = nil
  while choice != 'n'
    Event.months_events(current_date).each { |event| puts event.description }
    puts "would you like another?"
    choice = gets.chomp
      if choice == 'y'
        current_date += 1.months
      end
  end
end

def search_events
  puts "What would you like to search?"
  input = gets.chomp
  result = Event.basic_search(input)
  result.each { |result| puts result.description}
end

menu
