class UsersController < ApplicationController
  before_filter :authenticate_user!
  include UsersHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events.all_events.page params[:page]
    if current_user?(@user)
      @event = Event.new
      session[:return_to] ||= request.referer
    end
  end

end
