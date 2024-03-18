class AddSavedToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_column :bookmarks, :saved, :boolean
  end
end
