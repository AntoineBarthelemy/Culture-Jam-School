class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @toi = Toi.new
    @post = Post.new(toi: @toi)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @toi = Toi.find_or_initialize_by(title: toi_params[:title]) if toi_params

    if @toi.nil?
      flash[:alert] = "Infos manquantes..."
      render :new, status: :unprocessable_entity and return
    end

    if @toi.new_record?
      if @toi.update(toi_params) && @toi.save
        @post.toi = @toi
      else
        flash[:alert] = "Infos manquantes..."
        render :new, status: :unprocessable_entity and return
      end
    else
      @post.toi = @toi
    end

    if @post.save!
      @post.rating = @post.rating * 2
      @post.save

      notify_post(@post)

      current_user.permitted = true
      current_user.save

      redirect_to toi_path(@post.toi), notice: 'Ton post a bien été créé'
    else
      flash[:alert] = "Infos manquantes..."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def toi_params
    return unless params.dig(:post, :toi_attributes)
    params[:post][:toi_attributes].permit!.to_h.merge({ title: params[:post][:toi], photo: params[:post][:photo], category_id: params[:post][:toi_attributes][:category_id].second  })
  end

  def post_params
    allowed_params = [:review, :rating, :user_id, :toi_id]
    if params[:post].present? && params[:post].is_a?(Hash)
      allowed_params << :additional_field if params[:post][:additional_field].present?
    end
    params.require(:post).permit(allowed_params)
  end

  def notify_post(post)
    post.user.following_users.each do |friend|
      next if friend == post.user

      notif = friend.notifications.create(post: post)

      NotificationChannel.broadcast_to(
        friend,
        render_to_string(partial: "shared/post_notification", locals: { post: notif.post, notif: notif })
      )
    end
  end
end
