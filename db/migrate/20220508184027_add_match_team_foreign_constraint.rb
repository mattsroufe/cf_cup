class AddMatchTeamForeignConstraint < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :match_teams, :teams
    add_foreign_key :match_teams, :matches
    add_foreign_key :players, :teams
    add_foreign_key :matches, :courses
  end
end
