class RemoveColumnsToTois < ActiveRecord::Migration[7.1]
  def change
    remove_columns :tois, :director, :author, :actors
  end
end
