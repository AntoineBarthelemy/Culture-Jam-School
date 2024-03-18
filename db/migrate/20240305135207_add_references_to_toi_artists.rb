class AddReferencesToToiArtists < ActiveRecord::Migration[7.1]
  def change
    add_reference :toi_artists, :artist, foreign_key: true
    add_reference :toi_artists, :toi, foreign_key: true
  end
end
