class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy ]

  # GET /matches or /matches.json
  def index
    hmac_secret = ENV["SECRET_KEY_BASE"]
    token = JWT.encode({ role: 'cf_cup_app' }, hmac_secret, 'HS256')
    url = "#{Rails.application.config.api_url}/matches?select=id,date,teams(name,players(username)),courses(name)&order=date"
    headers = { 'Authorization' => "Bearer #{token}" }
    response = HTTParty.get(url, headers: headers, logger: Rails.logger, log_level: :info)
    if response.success?
      @matches = JSON.parse(response.body)
    else
      Rails.logger.error(response.body)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /matches/1 or /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches or /matches.json
  def create
    @match = Match.new(match_params.except(:home_team_id, :away_team_id)) do |match|
      match.teams << Team.find(match_params[:home_team_id])
      match.teams << Team.find(match_params[:away_team_id])
    end

    respond_to do |format|
      if @match.save
        format.html { redirect_to match_url(@match), notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    MatchTeam.where(match_id: @match.id).destroy_all
    @match.teams << Team.find(match_params[:home_team_id])
    @match.teams << Team.find(match_params[:away_team_id])
 
    respond_to do |format|
      if @match.update(match_params.except(:home_team_id, :away_team_id))
        format.html { redirect_to match_url(@match), notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url, notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.fetch(:match, {}).permit(:course_id, :home_team_id, :away_team_id, :date)
    end
end
