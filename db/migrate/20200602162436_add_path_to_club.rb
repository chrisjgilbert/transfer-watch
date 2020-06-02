class AddPathToClub < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :path, :string
  end
end
