class AddPuttCountAndLostBallCountToScore < ActiveRecord::Migration[7.0]
  def change
    rename_column :scores, :score, :total_count
    add_column :scores, :putt_count, :integer
    add_column :scores, :lost_ball_count, :integer
  end
end
