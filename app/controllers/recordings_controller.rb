class RecordingsController < ApplicationController
  def index
  end


  def edit
  end

  def update
  end

  def new
    @recording = Recording.new
  end

  def create
    @recording = Recording.new(recording_params)
    if  @recording.save
      redirect_to root_path
    end
  end

  def show
    @recording = Recording.find(params[:id])
  end

  def delete
  end

  def like
    @recording = Recording.find(params[:id])
    @recording.liked_by current_user
    redirect_to @recording
  end

  def unlike
    @recording = Recording.find(params[:id])
    @recording.unliked_by current_user
    redirect_to @recording
  end

private
  def recording_params
    params.require(:recording).permit(:title,:sound, :description, :latitude, :longitude, :tag_list)
  end

end
