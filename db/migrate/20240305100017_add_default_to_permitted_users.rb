class AddDefaultToPermittedUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :permitted, false
  end
end
