class Player < ApplicationRecord
  belongs_to :team
  has_many :match_hole_player_scores
end
