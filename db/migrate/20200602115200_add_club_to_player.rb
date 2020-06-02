class AddClubToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_reference :players, :club, index: true
  end
end
