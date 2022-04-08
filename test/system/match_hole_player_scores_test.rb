require "application_system_test_case"

class MatchHolePlayerScoresTest < ApplicationSystemTestCase
  setup do
    @match_hole_player_score = match_hole_player_scores(:one)
  end

  test "visiting the index" do
    visit match_hole_player_scores_url
    assert_selector "h1", text: "Match hole player scores"
  end

  test "should create match hole player score" do
    visit match_hole_player_scores_url
    click_on "New match hole player score"

    fill_in "Hole", with: @match_hole_player_score.hole_id
    fill_in "Match", with: @match_hole_player_score.match_id
    fill_in "Player", with: @match_hole_player_score.player_id
    fill_in "Score", with: @match_hole_player_score.score
    click_on "Create Match hole player score"

    assert_text "Match hole player score was successfully created"
    click_on "Back"
  end

  test "should update Match hole player score" do
    visit match_hole_player_score_url(@match_hole_player_score)
    click_on "Edit this match hole player score", match: :first

    fill_in "Hole", with: @match_hole_player_score.hole_id
    fill_in "Match", with: @match_hole_player_score.match_id
    fill_in "Player", with: @match_hole_player_score.player_id
    fill_in "Score", with: @match_hole_player_score.score
    click_on "Update Match hole player score"

    assert_text "Match hole player score was successfully updated"
    click_on "Back"
  end

  test "should destroy Match hole player score" do
    visit match_hole_player_score_url(@match_hole_player_score)
    click_on "Destroy this match hole player score", match: :first

    assert_text "Match hole player score was successfully destroyed"
  end
end
