class AddSourceToRumour < ActiveRecord::Migration[5.2]
  def change
    add_reference :rumours, :source, foreign_key: true
  end
end
