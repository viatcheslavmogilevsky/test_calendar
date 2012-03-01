class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
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
