class AddMatchIdIndexToScores < ActiveRecord::Migration[7.0]
  def change
    add_index :scores, :match_id
  end
end
