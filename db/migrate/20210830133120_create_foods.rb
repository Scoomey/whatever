class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :dish
      t.string :image
      t.timestamps
    end
  end
end
