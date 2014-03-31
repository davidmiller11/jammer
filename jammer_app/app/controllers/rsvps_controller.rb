# rsvps_controller.rb
class RsvpsController < ApplicationController

  def index
  end

  def new
    @jam = Jam.find(session[:jam_id])
    @user = @jam.user
    @rsvp = Rsvp.new
  end

  def create
    @jam = Jam.find(session[:jam_id])

    @invitee_user_ids = []

    params[:invitees].each_key do |key|
      @invitee_user_ids << key.to_i
    end  

    # @invitee_user_ids has array of user_id's

    Rsvp.create_many(@jam.jam_times, @invitee_user_ids)

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

  # private
  #   def rsvp_params
  #   end

end