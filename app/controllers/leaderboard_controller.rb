class LeaderboardController < ApplicationController

  def index
    @holes = Hole.all.to_a
    # @scores = ActiveRecord::Base.connection.execute(
    #   "select scores.player_id, holes.par, holes.stroke, scores.total_count, scores.putt_count, scores.lost_ball_count, players.handicap, coalesce(coalesce(scores.total_count, 0), scores.total_count) AS points from scores join holes on holes.id = scores.hole_id join players on players.id = scores.player_id limit 1;"
    # )
  end
end
