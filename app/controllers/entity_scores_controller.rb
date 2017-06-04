class EntityScoresController < ApplicationController
  before_action :set_entity_score, only: [:show, :edit, :update, :destroy]

  # GET /entity_scores
  # GET /entity_scores.json
  def index
    @entity_scores = EntityScore.all
  end

  # GET /entity_scores/1
  # GET /entity_scores/1.json
  def show
  end

  # GET /entity_scores/new
  def new
    @entity_score = EntityScore.new
  end

  # GET /entity_scores/1/edit
  def edit
  end

  # POST /entity_scores
  # POST /entity_scores.json
  def create
    @entity_score = EntityScore.new(entity_score_params)

    respond_to do |format|
      if @entity_score.save
        format.html { redirect_to @entity_score, notice: 'Entity score was successfully created.' }
        format.json { render :show, status: :created, location: @entity_score }
      else
        format.html { render :new }
        format.json { render json: @entity_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entity_scores/1
  # PATCH/PUT /entity_scores/1.json
  def update
    respond_to do |format|
      if @entity_score.update(entity_score_params)
        format.html { redirect_to @entity_score, notice: 'Entity score was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity_score }
      else
        format.html { render :edit }
        format.json { render json: @entity_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_scores/1
  # DELETE /entity_scores/1.json
  def destroy
    @entity_score.destroy
    respond_to do |format|
      format.html { redirect_to entity_scores_url, notice: 'Entity score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity_score
      @entity_score = EntityScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entity_score_params
      params.require(:entity_score).permit(:entity_id, :entity_type, :user_id, :exam_set_id, :exam_id)
    end
end
