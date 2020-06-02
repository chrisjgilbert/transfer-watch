class CreateRumours < ActiveRecord::Migration[5.2]
  def change
    create_table :rumours do |t|
      t.string :description

      t.timestamps
    end
  end
end
