# jam_times_controller.rb
class JamTimesController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])
    @jam_time = JamTime.new
  end

  def create
    @jam = Jam.find(session[:jam_id])
    @jam_time = JamTime.create(jam_time_params)
    @jam.jam_times << @jam_time
    
    session[:jam_time_id] = @jam_time.id
    # redirect_to new_rsvp_path
    redirect_to @jam
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
    def jam_time_params
      return params.require(:jam_time).permit(:start_date, :start_time)
    end

end