# rsvps_controller.rb
class RsvpsController < ApplicationController

  def index
    @jams_invited_to = current_user.jams_invited_to
  end

  def new
    @jam = Jam.find(session[:jam_id])
    @user = @jam.user

    if @user.id == current_user.id || current_user.admin
      @rsvp = Rsvp.new
    else
      redirect_to @jam
    end
    
  end

  def create
    @jam = Jam.find(session[:jam_id])

    @invitee_user_ids = []

    params[:invitees].each_key do |key|
      @invitee_user_ids << key.to_i
    end  

    # @invitee_user_ids has array of user_id's

    Rsvp.create_many(@jam.jam_times, @invitee_user_ids)

    UserMailer.invite_email(@jam, @invitee_user_ids).deliver
    
    redirect_to @jam
  end

  def show
    
  end

  def edit
    @rsvp = Rsvp.find(params[:id])

    if !current_user.admin && (current_user.id != @rsvp.user_id)
      redirect_to :back
    end

    @user = User.find(@rsvp.user_id)
    @jam_time = JamTime.find(@rsvp.jam_time_id)
    @jam = Jam.find(@jam_time.jam_id)

    # find me all the rsvps for given user
    @user_rsvps = Rsvp.where(user_id: @user.id)

    # find me all the jam_times belonging to the jam we wish to edit rsvps for
    @jam_times = JamTime.where(jam_id: @jam.id)
    @jam_time_ids = @jam_times.map do |jam_time|
      jam_time.id
    end

    # find rsvp_ids for the rsvps where user and jam_time match
    @rsvp_ids_to_edit = []

    @user_rsvps.each do |user_rsvp|
      if @jam_time_ids.include?(user_rsvp.jam_time_id.to_i)
        @rsvp_ids_to_edit << user_rsvp.id
        # binding.pry
      end 
    end

    # render text: @rsvp_ids_to_edit.inspect
    params[:rsvp_ids_to_edit] = @rsvp_ids_to_edit
  end

  def update
    # render text: params.inspect
    @answers = params[:answers]

    @answers.each do |rsvp_id, rsvp_answer|
      @rsvp = Rsvp.find(rsvp_id.to_i)
      @rsvp.update(answer: rsvp_answer)
    end

    @jam = Jam.find(JamTime.find(@rsvp.jam_time_id).jam_id)

    redirect_to @jam

  end

  def destroy
    @rsvp = Rsvp.find(params[:id])

    if !current_user.admin && (current_user.id != @rsvp.user_id)
      redirect_to :back
    end

    @user = User.find(@rsvp.user_id)
    @jam_time = JamTime.find(@rsvp.jam_time_id)
    @jam = Jam.find(@jam_time.jam_id)

    # find me all the rsvps for given user
    @user_rsvps = Rsvp.where(user_id: @user.id)

    # find me all the jam_times belonging to the jam we wish to edit rsvps for
    @jam_times = JamTime.where(jam_id: @jam.id)
    @jam_time_ids = @jam_times.map do |jam_time|
      jam_time.id
    end

    # find rsvp_ids for the rsvps where user and jam_time match
    @rsvp_ids_to_delete = []

    @user_rsvps.each do |user_rsvp|
      if @jam_time_ids.include?(user_rsvp.jam_time_id.to_i)
        @rsvp_ids_to_delete << user_rsvp.id
        # binding.pry
      end 
    end

    @jam = Jam.find(JamTime.find(@rsvp.jam_time_id).jam_id)


    # need to destroy more than one RSVP
    @rsvp_ids_to_delete.each do |rsvp_id|

      Rsvp.find(rsvp_id).destroy

    end

    redirect_to @jam

  end

  # private
  #   def rsvp_params
  #   end

end