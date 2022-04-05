require "application_system_test_case"

class MatchTeamsTest < ApplicationSystemTestCase
  setup do
    @match_team = match_teams(:one)
  end

  test "visiting the index" do
    visit match_teams_url
    assert_selector "h1", text: "Match teams"
  end

  test "should create match team" do
    visit match_teams_url
    click_on "New match team"

    fill_in "Match", with: @match_team.match_id
    fill_in "Team", with: @match_team.team_id
    click_on "Create Match team"

    assert_text "Match team was successfully created"
    click_on "Back"
  end

  test "should update Match team" do
    visit match_team_url(@match_team)
    click_on "Edit this match team", match: :first

    fill_in "Match", with: @match_team.match_id
    fill_in "Team", with: @match_team.team_id
    click_on "Update Match team"

    assert_text "Match team was successfully updated"
    click_on "Back"
  end

  test "should destroy Match team" do
    visit match_team_url(@match_team)
    click_on "Destroy this match team", match: :first

    assert_text "Match team was successfully destroyed"
  end
end
