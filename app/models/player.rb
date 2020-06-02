class Player < ApplicationRecord

  has_many :rumours

  def already_linked_with_club?(club)
    Rumour.where(club_id: club.id, player_id: self.id).exists?
  end

  def plays_for_club?(club)
    self.club_id == club.id
  end

end
