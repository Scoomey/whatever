class RemoveTypeFromFood < ActiveRecord::Migration[6.0]
  def change
    remove_column :foods, :type, :string
  end
end
