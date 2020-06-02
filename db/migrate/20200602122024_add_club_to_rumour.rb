class AddClubToRumour < ActiveRecord::Migration[5.2]
  def change
    add_reference :rumours, :club, foreign_key: true
  end
end
