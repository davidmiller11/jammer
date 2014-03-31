# events_controller.rb
class EventsController < ApplicationController

  before_action :require_authentication, only: [:index]

  def index
    @events = current_user.events + Event.where({:creator_id => current_user.id})
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.finalized = false
    @event.creator_id = current_user.id
    @event.save
    redirect_to 
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
  end

  private
    def event_params
      return params.require(:event).permit(:name, :description, :location, :allow_date_prop)
    end

end