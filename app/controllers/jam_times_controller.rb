# jam_times_controller.rb
class JamTimesController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])
    if current_user == @jam.creator && @jam.rsvps.empty?
      @jam_time = JamTime.new
    else
      flash[:notice] = "Cannot propose another time after invites have been sent.  To add more times, please create a new jam."
      redirect_to @jam
    end
  end

  def create
    @jam = Jam.find(session[:jam_id])

    # Only create jam_time if there are no rsvps, since users will already have responded.
    if @jam.rsvps.empty?
      @jam_time = @jam.jam_times.new(jam_time_params)
      if @jam_time.save
        session[:jam_time_id] = @jam_time.id
        redirect_to @jam
      else
        render :new
      end
    else
      # If users have already been invited, redirect back to view jam.
      redirect_to @jam
    end
  end

  def destroy
    redirect_to :back
  end

  private
    def jam_time_params
      return params.require(:jam_time).permit(:start_date, :start_time)
    end

end