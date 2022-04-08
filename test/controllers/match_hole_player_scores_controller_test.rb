require "test_helper"

class MatchHolePlayerScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_hole_player_score = match_hole_player_scores(:one)
  end

  test "should get index" do
    get match_hole_player_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_match_hole_player_score_url
    assert_response :success
  end

  test "should create match_hole_player_score" do
    assert_difference("MatchHolePlayerScore.count") do
      post match_hole_player_scores_url, params: { match_hole_player_score: { hole_id: @match_hole_player_score.hole_id, match_id: @match_hole_player_score.match_id, player_id: @match_hole_player_score.player_id, score: @match_hole_player_score.score } }
    end

    assert_redirected_to match_hole_player_score_url(MatchHolePlayerScore.last)
  end

  test "should show match_hole_player_score" do
    get match_hole_player_score_url(@match_hole_player_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_hole_player_score_url(@match_hole_player_score)
    assert_response :success
  end

  test "should update match_hole_player_score" do
    patch match_hole_player_score_url(@match_hole_player_score), params: { match_hole_player_score: { hole_id: @match_hole_player_score.hole_id, match_id: @match_hole_player_score.match_id, player_id: @match_hole_player_score.player_id, score: @match_hole_player_score.score } }
    assert_redirected_to match_hole_player_score_url(@match_hole_player_score)
  end

  test "should destroy match_hole_player_score" do
    assert_difference("MatchHolePlayerScore.count", -1) do
      delete match_hole_player_score_url(@match_hole_player_score)
    end

    assert_redirected_to match_hole_player_scores_url
  end
end
