class HomeController < ApplicationController
  def index
    if user_signed_in?
      @events = Event.all_events.page params[:page]
      @event = Event.new
      session[:return_to] ||= request.referer
    end
  end
end
