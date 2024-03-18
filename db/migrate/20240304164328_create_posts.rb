class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :photo
      t.text :review
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :toi, null: false, foreign_key: true

      t.timestamps
    end
  end
end
