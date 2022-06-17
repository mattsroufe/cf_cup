class AddScorecardView < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.connection.execute "
      CREATE OR REPLACE VIEW scorecards AS
      WITH scores_with_adjusted_par AS (
        SELECT
        scores.match_id,
        holes.number,
        scores.total_count,
        scores.player_id,
        scores.hole_id,
        CASE
          WHEN holes.stroke <= match_players.handicap THEN holes.par + 1
          WHEN holes.stroke <= match_players.handicap - 18 THEN holes.par + 2
          ELSE holes.par
        END AS adjusted_par
        FROM scores
        JOIN holes ON scores.hole_id = holes.id
        JOIN match_players using(player_id)
      )
      SELECT
        number,
        total_count,
        adjusted_par,
        match_id,
        hole_id,
        player_id,
        CASE
          WHEN total_count = adjusted_par + 1 THEN 1
          WHEN total_count = adjusted_par THEN 2
          WHEN total_count = adjusted_par - 1  THEN 3
          WHEN total_count = adjusted_par - 2  THEN 4
          WHEN total_count = adjusted_par - 3  THEN 5
          ELSE 0
        END AS points
      FROM scores_with_adjusted_par
    ;"
  end

  def down
    ActiveRecord::Base.connection.execute "DROP VIEW IF EXISTS scorecards;"
  end
end
