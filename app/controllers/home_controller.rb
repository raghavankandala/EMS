class HomeController < ApplicationController

  def index
    @upcoming_events = Event.upcoming.order('start_date ASC')
    @recent_events = Event.recent
  end

  
end
