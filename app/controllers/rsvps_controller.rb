# rsvps_controller.rb
class RsvpsController < ApplicationController

  before_action :require_authentication

  def index
    @jams_invited_to = current_user.jams_invited_to
  end

  def new
    # inviting 1 or more friends to jam
    jam = Jam.find(session[:jam_id])
    creator = jam.creator
    invitee_ids = jam.invitee_ids
    @uninvited_friends = creator.friends.reject { |friend| invitee_ids.include?(friend.id) }

    if (current_user.id == creator.id || current_user.admin) && !@uninvited_friends.empty?
      @rsvp = Rsvp.new
    else
      flash[:notice] = "You have already invited all of your friends.  In order to invite another person, you must first add that user to your Friend List."
      redirect_to jam
    end
    
  end

  def create
    @jam = Jam.find(session[:jam_id])
    email_count = 0;

    new_invitee_ids = params[:invitees].keys.map { |key| key.to_i }

    Rsvp.create_many(@jam.jam_times, new_invitee_ids)

    # Send an invite_email to each invited user
    new_invitee_ids.each do |new_invitee_id|
      UserMailer.invite_email(@jam, new_invitee_id).deliver
      email_count += 1;
    end
    flash[:notice] = "Invitations have been sent to #{email_count} friend(s)!" if email_count > 0
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
      end 
    end

    params[:rsvp_ids_to_edit] = @rsvp_ids_to_edit
  end

  def update
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
    @user = @rsvp.user
    @jam_time = @rsvp.jam_time
    @jam = @jam_time.jam

    if !current_user.admin && (current_user.id != @rsvp.user_id) && current_user.id != @jam.user_id
      redirect_to :back
    else
      @user_rsvps = @user.rsvps

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
        end 
      end
      @jam = Jam.find(JamTime.find(@rsvp.jam_time_id).jam_id)
      # need to destroy more than one RSVP
      @rsvp_ids_to_delete.each do |rsvp_id|
        Rsvp.find(rsvp_id).destroy
      end
      redirect_to @jam
    end
  end
end