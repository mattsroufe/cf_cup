class CreateMatchHolePlayerScores < ActiveRecord::Migration[7.0]
  def change
    create_table :match_hole_player_scores do |t|
      t.integer :match_id
      t.integer :hole_id
      t.integer :player_id
      t.integer :score

      t.timestamps
    end
  end
end
