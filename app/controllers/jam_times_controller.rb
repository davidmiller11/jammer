# jam_times_controller.rb
class JamTimesController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])
    if current_user == @jam.creator && @jam.rsvps.empty?
      @jam_time = JamTime.new
    else
      flash[:notice] = "You cannot add another time after you have already invited users to jam.  To add more times, you have to create a new jam."
      redirect_to @jam
    end
  end

  def create
    @jam = Jam.find(session[:jam_id])
    if @jam.rsvps.empty?
      @jam_time = @jam.jam_times.create(jam_time_params)
      session[:jam_time_id] = @jam_time.id
    end
      redirect_to @jam
  end

  def destroy
    redirect_to :back
  end

  private
    def jam_time_params
      return params.require(:jam_time).permit(:start_date, :start_time)
    end

end