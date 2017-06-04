class AttemptAnswersController < ApplicationController
  before_action :set_attempt_answer, only: [:show, :edit, :update, :destroy]

  # GET /attempt_answers
  # GET /attempt_answers.json
  def index
    @attempt_answers = AttemptAnswer.all
  end

  # GET /attempt_answers/1
  # GET /attempt_answers/1.json
  def show
  end

  # GET /attempt_answers/new
  def new
    @attempt_answer = AttemptAnswer.new
  end

  # GET /attempt_answers/1/edit
  def edit
  end

  # POST /attempt_answers
  # POST /attempt_answers.json
  def create
    @attempt_answer = AttemptAnswer.new(attempt_answer_params)

    respond_to do |format|
      if @attempt_answer.save
        format.html { redirect_to @attempt_answer, notice: 'Attempt answer was successfully created.' }
        format.json { render :show, status: :created, location: @attempt_answer }
      else
        format.html { render :new }
        format.json { render json: @attempt_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempt_answers/1
  # PATCH/PUT /attempt_answers/1.json
  def update
    respond_to do |format|
      if @attempt_answer.update(attempt_answer_params)
        format.html { redirect_to @attempt_answer, notice: 'Attempt answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt_answer }
      else
        format.html { render :edit }
        format.json { render json: @attempt_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempt_answers/1
  # DELETE /attempt_answers/1.json
  def destroy
    @attempt_answer.destroy
    respond_to do |format|
      format.html { redirect_to attempt_answers_url, notice: 'Attempt answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt_answer
      @attempt_answer = AttemptAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_answer_params
      params.require(:attempt_answer).permit(:answer_id, :question_id, :exam_attempt_id)
    end
end
