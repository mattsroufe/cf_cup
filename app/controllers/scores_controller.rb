class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

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
          @players = @match.teams.sort_by(&:id).map { |team| team.players.sort_by(&:id) }.flatten
          @scorecard = Scorecard.where(match_id: params[:match_id]).order(:number)
        end
      end
    end
 end

  def show
  end

  def new
    @match = Match.where(id: score_params[:match_id]).includes(teams: :players).first!
    @hole = Hole.find(score_params[:hole_id])
    @players = @match.players
    @scores = Score.where(match_id: @match.id, hole_id: @hole.id, player_id: @players.ids)
  end

  def edit
  end

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

  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to new_score_path(score: { match_id: @score.match_id, hole_id: @score.hole_id }), notice: "Score was successfully updated." }
        format.json { render json: @score, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

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
