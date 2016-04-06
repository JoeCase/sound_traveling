class RecordingsController < ApplicationController

  skip_before_action :authenticate_user!,  only: [:index, :show]

  autocomplete :tag, :name, class_name: 'ActsAsTaggableOn::Tag'

  def index
    @q = Recording.ransack(params[:q])
    @recordings = @q.result(distinct: true)
    render 'welcome/index'
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
    if @recording.save
      redirect_to recording_path(@recording)
    else
      render :new
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
    params[:recording][:tag_list] = params[:recording][:tag_list].join(',')
    params.require(:recording).permit(:title, :sound, :channels, :description, :latitude, :longitude, :tag_list).merge(user: current_user)
  end

end
