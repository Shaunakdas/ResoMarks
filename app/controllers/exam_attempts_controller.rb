class ExamAttemptsController < ApplicationController
  before_action :set_exam_attempt, only: [:show, :edit, :update, :destroy]

  # GET /exam_attempts
  # GET /exam_attempts.json
  def index
    @exam_attempts = ExamAttempt.all
  end

  # GET /exam_attempts/1
  # GET /exam_attempts/1.json
  def show
  end

  # GET /exam_attempts/new
  def new
    @exam_attempt = ExamAttempt.new
  end

  # GET /exam_attempts/1/edit
  def edit
  end

  # POST /exam_attempts
  # POST /exam_attempts.json
  def create
    @exam_attempt = ExamAttempt.new(exam_attempt_params)

    respond_to do |format|
      if @exam_attempt.save
        format.html { redirect_to @exam_attempt, notice: 'Exam attempt was successfully created.' }
        format.json { render :show, status: :created, location: @exam_attempt }
      else
        format.html { render :new }
        format.json { render json: @exam_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_attempts/1
  # PATCH/PUT /exam_attempts/1.json
  def update
    respond_to do |format|
      if @exam_attempt.update(exam_attempt_params)
        format.html { redirect_to @exam_attempt, notice: 'Exam attempt was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_attempt }
      else
        format.html { render :edit }
        format.json { render json: @exam_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_attempts/1
  # DELETE /exam_attempts/1.json
  def destroy
    @exam_attempt.destroy
    respond_to do |format|
      format.html { redirect_to exam_attempts_url, notice: 'Exam attempt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_attempt
      @exam_attempt = ExamAttempt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_attempt_params
      params.require(:exam_attempt).permit(:name, :exam_id, :exam_set_id, :user_id)
    end
end
