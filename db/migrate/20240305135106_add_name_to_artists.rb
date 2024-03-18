class AddNameToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :name, :string
  end
end
