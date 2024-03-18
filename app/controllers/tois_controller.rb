class ToisController < ApplicationController
  before_action :set_toi, only: [:show]

  def index
    @tois = Toi.all.order(created_at: :desc)

    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @tois = @tois.where(category: @category)
    end

    if params[:query].present?
      query = params[:query]
      @tois = @tois.where("LOWER(title) LIKE ?", "%#{query.downcase}%")
    end

    if params[:filter_criteria] == "rating"
      @tois = @tois.joins(:posts)
                   .group("tois.id")
                   .select("tois.*, AVG(rating) AS average_rating")
                   .reorder(average_rating: :desc)
    elsif params[:filter_criteria] == "posts"
      @tois = @tois.joins(:posts)
                   .group("tois.id")
                   .select("tois.*, COUNT(posts.id) AS nb_of_posts")
                   .reorder(nb_of_posts: :desc)
    end

    @search_params = params.permit(:category_id, :query).to_h
  end

  def show
    if request.referer.include?('tois')
      @posts = @toi.posts.order(created_at: :desc)
    else
      @posts = @toi.followed_users_posts(current_user).order(created_at: :desc)
    end
    @post_ratings = @posts.map { |post| [post, post.rating] }
  end

  def find_toi
    toi = Toi.find_by(name: params[:name])
    render json: toi
  end

  private

  def set_toi
    @toi = Toi.find(params[:id])
  end

  def toi_params
    params.require(:toi).permit(:title, :category_id, :location, :description, :trailer, :photo)
  end
end
