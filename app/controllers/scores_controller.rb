class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

  # GET /scores or /scores.json
  def index
    @match = Match.find(params[:match_id])

    respond_to do |format|
      if params[:hole_number]
        hole = Hole.find_by(course_id: @match.course_id, number: params[:hole_number])
        @scores = Score.where(match_id: params[:match_id], hole_id: hole.id)
        format.json do
          render json: {
            hole: hole,
            scores: @scores.map do |score|
              score.as_json.merge(url: score_url(score, format: :json))
            end
          }.as_json
        end
      else
        format.html do
          @players = Player.where(team_id: @match.teams.pluck(:id)).order(:team_id)
          @scorecard = Scorecard.where(match_id: params[:match_id])
        end
      end
    end
 end

  # GET /scores/1 or /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @match = Match.where(id: score_params[:match_id]).includes(:teams).first!
    @hole = Hole.find(score_params[:hole_id])
    @players = Player.where(team_id: @match.teams.pluck(:id))
    @scores = Score.where(match_id: @match.id, hole_id: @hole.id, player_id: @players.ids)
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores or /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to new_score_path(score: { match_id: @score.match_id, hole_id: @score.hole_id }), notice: "Score was successfully created." }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to new_score_path(score: { match_id: @score.match_id, hole_id: @score.hole_id }), notice: "Score was successfully updated." }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy

    respond_to do |format|
      format.html { redirect_to scores_url, notice: "Score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:match_id, :hole_id, :player_id, :total_count, :putt_count, :lost_ball_count)
    end
end
