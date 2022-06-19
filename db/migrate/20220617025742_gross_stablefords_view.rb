class GrossStablefordsView < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.connection.execute "
      CREATE OR REPLACE VIEW gross_stablefords AS
        SELECT
        holes.number,
        holes.par,
        holes.stroke,
        scores.total_count as gross_score,
        match_players.handicap,
        ceil(greatest(handicap - stroke, 0) / 18) as strokes_given,
        scores.hole_id,
        scores.match_id,
        scores.player_id,
        team_players.team_id
        FROM scores
        JOIN holes ON scores.hole_id = holes.id
        JOIN match_players using(player_id)
        JOIN team_players using(player_id)
    ;"
  end

  def down
    ActiveRecord::Base.connection.execute "DROP VIEW IF EXISTS gross_stablefords;"
  end
end

