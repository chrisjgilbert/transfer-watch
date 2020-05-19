class CreatePlayersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :players_tables do |t|
      t.string :name

      t.timestamps
    end
  end
end
