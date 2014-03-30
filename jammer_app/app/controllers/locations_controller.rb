# locations_controller.rb
class LocationsController < ApplicationController

  def index
  end

  def new
    @location = Location.new 
    @event = Event.find(params[:event_id])
  end

  def create
    @location = Location.create(location_params)
    render text: params.inspect
    # redirect_to events_path
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def location_params
      return params.require(:location).permit(:name)
    end

end