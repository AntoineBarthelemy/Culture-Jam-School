class ChangeSynopsisToDescription < ActiveRecord::Migration[7.1]
  def change
    rename_column :tois, :synopsis, :description
  end
end
