class CommentsController < ApplicationController
  def show
  end

  def new
    @recording = Recording.find(params[:recording_id])
    # @comment = @recording.comments.new
  end

  def create
    @recording = Recording.find(params[:recording_id])
    @comment = @recording.comments.new(comment_params)
    if @comment.save
      if request.xhr?
        flash[:success] = 'Comment posted.'
        render @comment, locals: {comment: @comment}, layout:false

      else
        ""
      end
    else
      flash[:alert] = "Didn't Save"
      redirect_to recording_path(@recording)
    end

  end

  def edit
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to recording_path(params[:recording_id])
  end

private
  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

end
