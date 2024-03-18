class RemoveNullFalseToPostInNotifications < ActiveRecord::Migration[7.1]
  def change
    change_column :notifications, :post_id, :integer, null: true
  end
end
