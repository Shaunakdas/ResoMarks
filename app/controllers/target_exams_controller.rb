class TargetExamsController < ApplicationController
  before_action :set_target_exam, only: [:show, :edit, :update, :destroy]

  # GET /target_exams
  # GET /target_exams.json
  def index
    @target_exams = TargetExam.all
  end

  # GET /target_exams/1
  # GET /target_exams/1.json
  def show
  end

  # GET /target_exams/new
  def new
    @target_exam = TargetExam.new
  end

  # GET /target_exams/1/edit
  def edit
  end

  # POST /target_exams
  # POST /target_exams.json
  def create
    @target_exam = TargetExam.new(target_exam_params)

    respond_to do |format|
      if @target_exam.save
        format.html { redirect_to @target_exam, notice: 'Target exam was successfully created.' }
        format.json { render :show, status: :created, location: @target_exam }
      else
        format.html { render :new }
        format.json { render json: @target_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /target_exams/1
  # PATCH/PUT /target_exams/1.json
  def update
    respond_to do |format|
      if @target_exam.update(target_exam_params)
        format.html { redirect_to @target_exam, notice: 'Target exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @target_exam }
      else
        format.html { render :edit }
        format.json { render json: @target_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_exams/1
  # DELETE /target_exams/1.json
  def destroy
    @target_exam.destroy
    respond_to do |format|
      format.html { redirect_to target_exams_url, notice: 'Target exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target_exam
      @target_exam = TargetExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_exam_params
      params.require(:target_exam).permit(:name)
    end
end
