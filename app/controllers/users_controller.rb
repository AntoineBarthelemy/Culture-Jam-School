class UsersController < ApplicationController
  before_action :set_user, only: %i[show follow unfollow read_notifications]

  def show
  end

  def update
    current_user.update(permitted: false)
    redirect_to root_path
  end

  def follow
    new_follow = current_user.friends.new(following_id: @user.id)
    if new_follow.save!
      notify_friend(new_follow)
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  def unfollow
    friend = current_user.friends.find_by!(following_id: @user.id)
    friend.destroy
    redirect_to user_path(@user)
  end

  def read_notifications
    current_user.notifications.update_all(read: true)
    render json: { html: render_to_string(partial: "shared/notifications", locals: { user: current_user }, formats: :html) }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def notify_friend(new_follow)
    friend = new_follow.following
    return if friend == new_follow.follower

    notif = friend.notifications.create(friend: new_follow)
    NotificationChannel.broadcast_to(
      friend,
      render_to_string(partial: "shared/friend_notification", locals: { user: notif.friend.follower, notif: notif })
    )
  end
end
