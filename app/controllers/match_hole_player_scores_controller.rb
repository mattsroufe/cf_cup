class MatchHolePlayerScoresController < ApplicationController
  before_action :set_match_hole_player_score, only: %i[ show edit update destroy ]

  # GET /match_hole_player_scores or /match_hole_player_scores.json
  def index
    @match_hole_player_scores = MatchHolePlayerScore.all
  end

  # GET /match_hole_player_scores/1 or /match_hole_player_scores/1.json
  def show
  end

  # GET /match_hole_player_scores/new
  def new
    @match_hole_player_score = MatchHolePlayerScore.new
  end

  # GET /match_hole_player_scores/1/edit
  def edit
  end

  # POST /match_hole_player_scores or /match_hole_player_scores.json
  def create
    @match_hole_player_score = MatchHolePlayerScore.new(match_hole_player_score_params)

    respond_to do |format|
      if @match_hole_player_score.save
        format.html { redirect_to match_hole_player_score_url(@match_hole_player_score), notice: "Match hole player score was successfully created." }
        format.json { render :show, status: :created, location: @match_hole_player_score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match_hole_player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_hole_player_scores/1 or /match_hole_player_scores/1.json
  def update
    respond_to do |format|
      if @match_hole_player_score.update(match_hole_player_score_params)
        format.html { redirect_to match_hole_player_score_url(@match_hole_player_score), notice: "Match hole player score was successfully updated." }
        format.json { render :show, status: :ok, location: @match_hole_player_score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_hole_player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_hole_player_scores/1 or /match_hole_player_scores/1.json
  def destroy
    @match_hole_player_score.destroy

    respond_to do |format|
      format.html { redirect_to match_hole_player_scores_url, notice: "Match hole player score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_hole_player_score
      @match_hole_player_score = MatchHolePlayerScore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_hole_player_score_params
      params.require(:match_hole_player_score).permit(:match_id, :hole_id, :player_id, :score)
    end
end
