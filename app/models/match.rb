class Match < ApplicationRecord
  belongs_to :course
  has_many :match_teams, dependent: :destroy
  has_many :teams, through: :match_teams
end
