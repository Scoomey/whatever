class AddYearToMovie < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :year, :string
  end
end
