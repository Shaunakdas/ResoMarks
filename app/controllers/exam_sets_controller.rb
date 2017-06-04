class ExamSetsController < ApplicationController
  before_action :set_exam_set, only: [:show, :edit, :update, :destroy]

  # GET /exam_sets
  # GET /exam_sets.json
  def index
    @exam_sets = ExamSet.all
  end

  # GET /exam_sets/1
  # GET /exam_sets/1.json
  def show
  end

  # GET /exam_sets/new
  def new
    @exam_set = ExamSet.new
  end

  # GET /exam_sets/1/edit
  def edit
  end

  # POST /exam_sets
  # POST /exam_sets.json
  def create
    @exam_set = ExamSet.new(exam_set_params)

    respond_to do |format|
      if @exam_set.save
        format.html { redirect_to @exam_set, notice: 'Exam set was successfully created.' }
        format.json { render :show, status: :created, location: @exam_set }
      else
        format.html { render :new }
        format.json { render json: @exam_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_sets/1
  # PATCH/PUT /exam_sets/1.json
  def update
    respond_to do |format|
      if @exam_set.update(exam_set_params)
        format.html { redirect_to @exam_set, notice: 'Exam set was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam_set }
      else
        format.html { render :edit }
        format.json { render json: @exam_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_sets/1
  # DELETE /exam_sets/1.json
  def destroy
    @exam_set.destroy
    respond_to do |format|
      format.html { redirect_to exam_sets_url, notice: 'Exam set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_set
      @exam_set = ExamSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_set_params
      params.require(:exam_set).permit(:name, :sequence_number, :exam_date, :code, :exam_id)
    end
end
