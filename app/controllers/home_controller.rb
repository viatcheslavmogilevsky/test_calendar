class HomeController < ApplicationController
  def index
    if user_signed_in?
      @events = Event.latest_events(10)
      @event = Event.new
    end
  end
end
