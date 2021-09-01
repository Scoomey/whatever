class AddDishToFood < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :dish, :string
  end
end
