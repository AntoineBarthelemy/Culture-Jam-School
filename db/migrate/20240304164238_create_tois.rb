class CreateTois < ActiveRecord::Migration[7.1]
  def change
    create_table :tois do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.string :director
      t.string :actors
      t.string :location
      t.string :author
      t.text :synopsis
      t.string :trailer

      t.timestamps
    end
  end
end
