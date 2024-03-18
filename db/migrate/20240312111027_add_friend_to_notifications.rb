class AddFriendToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :friend, foreign_key: true
  end
end
