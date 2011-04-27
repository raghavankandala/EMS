module ApplicationHelper
  
  def event_time(event)
   if event.start_date.day == event.end_date.day
      event.start_date.strftime("On %A, %d %B %Y at %I:%M%p")
    else
      event.start_date.strftime("From %A, %d %B %Y %I:%M%p") << event.end_date.strftime(" To %A, %d %B %Y %I:%M%p")
   end 
  end

end
