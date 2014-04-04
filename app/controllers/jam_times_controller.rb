# jam_times_controller.rb
class JamTimesController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])

    if current_user.id == @jam.user_id
      @jam_time = JamTime.new
    else
      redirect_to @jam
    end
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
    redirect_to :back
  end

  def edit
    redirect_to :back
  end

  def update
    redirect_to :back
  end

  def destroy
    redirect_to :back
  end

  private
    def jam_time_params
      return params.require(:jam_time).permit(:start_date, :start_time)
    end

end