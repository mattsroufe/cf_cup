class Player < ApplicationRecord
  belongs_to :team
  belongs_to :match
  has_many :scores
end
