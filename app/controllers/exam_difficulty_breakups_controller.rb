class ExamDifficultyBreakupsController < ApplicationController
  before_action :set_exam_difficulty_breakup, only: [:show, :edit, :update, :destroy]

  # GET /exam_difficulty_breakups
  # GET /exam_difficulty_breakups.json
  def index
    @exam_difficulty_breakups = ExamDifficultyBreakup.all
  end

  # GET /exam_difficulty_breakups/1
  # GET /exam_difficulty_breakups/1.json
  def show
  end

  # GET /exam_difficulty_breakups/new
  def new
    @exam_difficulty_breakup = ExamDifficultyBreakup.new
  end

  # GET /exam_difficulty_breakups/1/edit
  def edit
  end

  # POST /exam_difficulty_breakups
  # POST /exam_difficulty_breakups.json
  def create
    @exam_difficulty_breakup = ExamDifficultyBreakup.new(exam_difficulty_breakup_params)

    respond_to do |format|
      if @exam_difficulty_breakup.save
        format.html { redirect_to @exam_difficulty_breakup, notice: 'Exam difficulty breakup was successfully created.' }
        format.json { render :show, status: :created, location: @exam_difficulty_breakup }
      else
        format.html { render :new }
        format.json { render json: @exam_difficulty_breakup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_difficulty_breakups/1
  # PATCH/PUT /exam_difficulty_breakups/1.json
  def update
    respond_to do |format|
      if @exam_difficulty_breakup.update(exam_difficulty_breakup_params)
        format.html { redirect_to @exam_difficulty_breakup, notice: 'Exam difficulty breakup was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_difficulty_breakup }
      else
        format.html { render :edit }
        format.json { render json: @exam_difficulty_breakup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_difficulty_breakups/1
  # DELETE /exam_difficulty_breakups/1.json
  def destroy
    @exam_difficulty_breakup.destroy
    respond_to do |format|
      format.html { redirect_to exam_difficulty_breakups_url, notice: 'Exam difficulty breakup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_difficulty_breakup
      @exam_difficulty_breakup = ExamDifficultyBreakup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_difficulty_breakup_params
      params.require(:exam_difficulty_breakup).permit(:count, :exam_id, :difficulty_level_id)
    end
end
