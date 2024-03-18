class AddColumnPermittedToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :permitted, :boolean
    add_column :users, :username, :string
  end
end
