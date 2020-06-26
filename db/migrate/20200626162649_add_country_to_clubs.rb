class AddCountryToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :country, :string
  end
end
