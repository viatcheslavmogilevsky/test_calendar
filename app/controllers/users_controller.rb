class UsersController < ApplicationController
  before_filter :authenticate_user!
  include UsersHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
    if current_user?(@user)
      @event = Event.new
      session[:return_to] ||= request.referer
    end
  end

  def events_for
    @user = User.find(params[:id])
    @events = @user.events_for("#{params[:day]}/#{params[:month]}/#{params[:year]}".to_date)
    respond_to do |f|
      f.html
      f.js
    end
  end
end
