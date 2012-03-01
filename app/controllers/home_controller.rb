class HomeController < ApplicationController
  def index
    @event = Event.new
    @users = User.all
  end
end
