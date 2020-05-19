class CreateClubsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs_tables do |t|
      t.string :name
 
      t.timestamps
    end
  end
end
