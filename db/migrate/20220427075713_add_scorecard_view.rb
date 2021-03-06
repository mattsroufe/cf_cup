class AddScorecardView < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.connection.execute "
      CREATE OR REPLACE VIEW scorecards AS WITH
      q0 AS (
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
      ),
      q1 AS (
        SELECT
          match_id,
          number,
          gross_score,
          player_id,
          hole_id,
          par,
          stroke,
          strokes_given,
          par + strokes_given as adjusted_par,
          team_id
        FROM q0
      ),
      q2 AS (
        SELECT
          team_id,
          number,
          par,
          stroke,
          strokes_given,
          gross_score,
          adjusted_par,
          match_id,
          hole_id,
          q1.player_id,
          CASE
            WHEN gross_score = adjusted_par + 1 THEN 1
            WHEN gross_score = adjusted_par THEN 2
            WHEN gross_score = adjusted_par - 1  THEN 3
            WHEN gross_score = adjusted_par - 2  THEN 4
            WHEN gross_score = adjusted_par - 3  THEN 5
            ELSE 0
          END AS points
        FROM q1
      ),
      q3 as (
      SELECT
        *,
        max(points) OVER (PARTITION BY hole_id, team_id ORDER BY points DESC) as team_points
      FROM q2
      )
      select
        min(match_id::text) as match_id,
        min(hole_id::text) as hole_id,
        min(team_id::text) as team_id,
        min(gross_score) as gross_score,
        min(points) as points,
        min(team_points) as team_points,
        min(par) as par,
        min(stroke) as stroke,
        player_id,
        number,
        sum(gross_score) as total_score,
        sum(points) as total_points,
        sum(team_points) as total_team_points from q3
        group by rollup (player_id, number) order by player_id, number;
    ;"
  end

  def down
    ActiveRecord::Base.connection.execute "DROP VIEW IF EXISTS scorecards;"
  end
end
