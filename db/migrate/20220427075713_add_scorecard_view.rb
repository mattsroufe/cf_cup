class AddScorecardView < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.connection.execute "
      CREATE OR REPLACE VIEW scorecards AS
      WITH scores_with_adjusted_par AS (
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
        FROM gross_stablefords
      )
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
        scores_with_adjusted_par.player_id,
        CASE
          WHEN gross_score = adjusted_par + 1 THEN 1
          WHEN gross_score = adjusted_par THEN 2
          WHEN gross_score = adjusted_par - 1  THEN 3
          WHEN gross_score = adjusted_par - 2  THEN 4
          WHEN gross_score = adjusted_par - 3  THEN 5
          ELSE 0
        END AS points
      FROM scores_with_adjusted_par
    ;"
  end

  def down
    ActiveRecord::Base.connection.execute "DROP VIEW IF EXISTS scorecards;"
  end
end
