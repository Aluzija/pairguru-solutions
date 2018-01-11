class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.includes(:genre)
    @api = API::PairguruApiController.new
  end

  def show
    @movie = Movie.find(params[:id])
    @title = @movie.title.split.join("%20")
    @comment = Comment.new
    @comments = @movie.comments
    @api = API::PairguruApiController.new
    if current_user
      current_user.comments.where(movie_id: @movie.id).empty? ? @commenting_permitted = true : @commenting_permitted = false
    end
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_to :back, notice: "Email sent with movie info"
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
