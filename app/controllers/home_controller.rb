class HomeController < ApplicationController

  def index
    @upcoming_events = Event.upcoming.order('start_date ASC')
  end
  
end
