class RemovePhotoFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :photo
  end
end
