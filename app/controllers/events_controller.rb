class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user, :except => [:create]

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = "add new event"
      redirect_to root_path
    else
      @events = []
      render 'home/index'
    end
  end

  def update
    if @event.update_attributes(params[:event])
      flash[:success] = "event updated"
      redirect_to session[:return_to]
    else
      render 'edit'
    end
  end

  def destroy
    @event_id = params[:id]
    @event_date = @event.calendar_date
    @event.destroy
    respond_to do |f|
      f.html { redirect_to root_path }
      f.js
    end
  end

  def edit
    respond_to do |f|
      f.html { session[:return_to] ||= request.referer}
      f.js
    end
  end

  private

  def check_user
    @event = Event.find(params[:id])
    redirect_to root_path if current_user != @event.user
  end
end
