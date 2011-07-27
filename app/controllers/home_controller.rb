class HomeController < ApplicationController

  def index
    @upcoming_events = Event.upcoming.order('start_date ASC')
    @recent_events = Event.recent
    @recent_surveys = Survey.recent
  end

  def alerts
    curr_time = Time.now.strftime("%F %X")
    @alerts = Alert.where("validity >= ?", curr_time).order("updated_at DESC").paginate(:page => (params[:page] || 1), :per_page => 1)
    if @alerts.empty? && params[:page].to_i != 1
      @alerts = Alert.where("validity >= ?", curr_time).order("updated_at DESC").paginate(:page => 1, :per_page => 1)
    end
  end

  
end
