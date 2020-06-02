class Club < ApplicationRecord

  has_many :players
  validates :name, presence: true, uniqueness: true
end
