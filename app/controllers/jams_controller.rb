# jams_controller.rb
class JamsController < ApplicationController

  before_action :require_authentication, only: [:index]

  def index
    @jams = current_user.jams
  end

  def all
    @jams = Jam.all
    render 'index.html.erb'
  end

  def new
    @jam = Jam.new
  end

  def create
    @jam = Jam.create(jam_params)
    @jam.finalized = false
    @jam.user_id = current_user.id
    @jam.save
    session[:jam_id] = @jam.id
    redirect_to new_jam_time_path
  end

  def show
    @jam = Jam.find(params[:id])
  end

  def edit
    @jam = Jam.find(params[:id])
    if @jam.user_id != current_user.id
      redirect_to @jam
    end
  end

  def update
    @jam = Jam.find(params[:id])
    @jam.update(jam_params)
    redirect_to jam_path(@jam)
  end

  def destroy
    @jam = Jam.find(params[:id])
    if current_user.admin || current_user.id == @jam.user_id
      @jam.destroy
      redirect_to jams_path
    else
      redirect_to @jam
    end
  end

  private
    def jam_params
      return params.require(:jam).permit(:name, :location, :description)
    end

end