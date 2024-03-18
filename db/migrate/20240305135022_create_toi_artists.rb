class CreateToiArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :toi_artists do |t|

      t.timestamps
    end
  end
end
