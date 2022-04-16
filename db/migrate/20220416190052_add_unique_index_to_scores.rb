class AddUniqueIndexToScores < ActiveRecord::Migration[7.0]
  def change
    add_index :scores, [:match_id, :hole_id, :player_id], unique: true
  end
end
