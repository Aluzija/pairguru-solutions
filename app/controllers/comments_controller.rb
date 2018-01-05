class CommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params)
    @comment.user_id = current_user.id
    redirect_to movie_path(@movie)
    if @comment.save
      flash[:notice] = "New comment was successfully created"
    else
      flash[:alert] = "Comment can't be blank"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to movie_path(params[:movie_id]), notice: "Comment was successfully deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
