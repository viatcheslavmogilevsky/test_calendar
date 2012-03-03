class HomeController < ApplicationController
  def index
    @event = Event.new
   # @events = Event.latest_events(10)
    @events = Event.all
  end
end
