class Match < ApplicationRecord
  belongs_to :course
  has_many :match_teams, dependent: :destroy
  has_many :teams, through: :match_teams
  has_many :match_players, dependent: :destroy
  has_many :players, through: :match_players
end
