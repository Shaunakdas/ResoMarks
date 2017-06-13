class UserQuestionScoresController < ApplicationController
  before_action :set_user_question_score, only: [:show, :edit, :update, :destroy]

  # GET /user_question_scores
  # GET /user_question_scores.json
  def index
    @user_question_scores = UserQuestionScore.all
  end

  # GET /user_question_scores/1
  # GET /user_question_scores/1.json
  def show
  end

  # GET /user_question_scores/new
  def new
    @user_question_score = UserQuestionScore.new
  end

  # GET /user_question_scores/1/edit
  def edit
  end

  # POST /user_question_scores
  # POST /user_question_scores.json
  def create
    @user_question_score = UserQuestionScore.new(user_question_score_params)

    respond_to do |format|
      if @user_question_score.save
        format.html { redirect_to @user_question_score, notice: 'User question score was successfully created.' }
        format.json { render :show, status: :created, location: @user_question_score }
      else
        format.html { render :new }
        format.json { render json: @user_question_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_question_scores/1
  # PATCH/PUT /user_question_scores/1.json
  def update
    respond_to do |format|
      if @user_question_score.update(user_question_score_params)
        format.html { redirect_to @user_question_score, notice: 'User question score was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_question_score }
      else
        format.html { render :edit }
        format.json { render json: @user_question_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_question_scores/1
  # DELETE /user_question_scores/1.json
  def destroy
    @user_question_score.destroy
    respond_to do |format|
      format.html { redirect_to user_question_scores_url, notice: 'User question score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_question_score
      @user_question_score = UserQuestionScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_question_score_params
      params.require(:user_question_score).permit(:correct, :incorrect, :blank, :partial, :value, :percentage, :effective_score, :question_id, :exam_attempt_id, :exam_set_id, :score_name_id)
    end
end
