# jam_times_controller.rb
class JamTimesController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])
    if current_user == @jam.creator
      @jam_time = JamTime.new
    else
      redirect_to @jam
    end
  end

  def create
    @jam = Jam.find(session[:jam_id])

    @jam_time = @jam.jam_times.new(jam_time_params)
    if @jam_time.save
      # Create Rsvp for the creator with answer of 'yes'
      Rsvp.create(user_id: current_user.id, jam_time_id: @jam_time.id, answer: 'yes')

      # Create Rsvp for other guests with answer of 'nil'
      

      session[:jam_time_id] = @jam_time.id
      redirect_to @jam
    else
      render :new
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