class ExamReferenceScoresController < ApplicationController
  before_action :set_exam_reference_score, only: [:show, :edit, :update, :destroy]

  # GET /exam_reference_scores
  # GET /exam_reference_scores.json
  def index
    @exam_reference_scores = ExamReferenceScore.all
  end

  # GET /exam_reference_scores/1
  # GET /exam_reference_scores/1.json
  def show
  end

  # GET /exam_reference_scores/new
  def new
    @exam_reference_score = ExamReferenceScore.new
  end

  # GET /exam_reference_scores/1/edit
  def edit
  end

  # POST /exam_reference_scores
  # POST /exam_reference_scores.json
  def create
    @exam_reference_score = ExamReferenceScore.new(exam_reference_score_params)

    respond_to do |format|
      if @exam_reference_score.save
        format.html { redirect_to @exam_reference_score, notice: 'Exam reference score was successfully created.' }
        format.json { render :show, status: :created, location: @exam_reference_score }
      else
        format.html { render :new }
        format.json { render json: @exam_reference_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_reference_scores/1
  # PATCH/PUT /exam_reference_scores/1.json
  def update
    respond_to do |format|
      if @exam_reference_score.update(exam_reference_score_params)
        format.html { redirect_to @exam_reference_score, notice: 'Exam reference score was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_reference_score }
      else
        format.html { render :edit }
        format.json { render json: @exam_reference_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_reference_scores/1
  # DELETE /exam_reference_scores/1.json
  def destroy
    @exam_reference_score.destroy
    respond_to do |format|
      format.html { redirect_to exam_reference_scores_url, notice: 'Exam reference score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_reference_score
      @exam_reference_score = ExamReferenceScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_reference_score_params
      params.require(:exam_reference_score).permit(:average, :maximum, :highest, :lowest, :exam_id, :entity_id, :entity_type)
    end
end
