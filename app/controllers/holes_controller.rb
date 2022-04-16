class HolesController < ApplicationController
  before_action :set_hole, only: %i[ show edit update destroy ]

  # GET /holes or /holes.json
  def index
    @holes = Hole.where(course_id: params[:course_id], number: params[:number])
  end

  # GET /holes/1 or /holes/1.json
  def show
  end

  # GET /holes/new
  def new
    @hole = Hole.new
  end

  # GET /holes/1/edit
  def edit
  end

  # POST /holes or /holes.json
  def create
    @hole = Hole.new(hole_params)

    respond_to do |format|
      if @hole.save
        format.html { redirect_to hole_url(@hole), notice: "Hole was successfully created." }
        format.json { render :show, status: :created, location: @hole }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holes/1 or /holes/1.json
  def update
    respond_to do |format|
      if @hole.update(hole_params)
        format.html { redirect_to hole_url(@hole), notice: "Hole was successfully updated." }
        format.json { render :show, status: :ok, location: @hole }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holes/1 or /holes/1.json
  def destroy
    @hole.destroy

    respond_to do |format|
      format.html { redirect_to holes_url, notice: "Hole was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hole
      @hole = Hole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hole_params
      params.require(:hole).permit(:course_id, :par, :stroke)
    end
end
