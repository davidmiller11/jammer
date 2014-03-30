# events_controller.rb
class EventsController < ApplicationController

  before_action :require_authentication, only: [:index]

  def index
    @events = current_user.events + Event.where(creator_id: current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.finalized = false
    @event.creator_id = current_user.id
    @event.save
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def event_params
      return params.require(:event).permit(:name, :description, :allow_date_prop)
    end

end