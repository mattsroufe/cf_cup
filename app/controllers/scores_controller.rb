class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

  # GET /scores or /scores.json
  def index
    @match = Match.find(params[:match_id])
    @scores = Score.where(match_id: params[:match_id], hole_id: params[:hole_id])
  end

  # GET /scores/1 or /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @match = Match.find(score_params[:match_id])
    @hole = Hole.find(score_params[:hole_id])
    previous_hole = Hole.find_by(course_id: @match.course_id, number: @hole.number - 1) if @hole.number > 0
    if previous_hole
      if @hole.number > 1
        @previous_score = Score.find_or_create_by(match_id: @match.id, hole_id: previous_hole.id) if previous_hole
      end
    end
    next_hole = Hole.find_by(course_id: @match.course_id, number: @hole.number + 1) if @hole.number > 0
    if next_hole
      if @hole.number < 18
        @next_score = Score.find_or_create_by(match_id: @match.id, hole_id: next_hole.id)
      end
    end
 
    @players = @match.teams.flat_map(&:players)
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
