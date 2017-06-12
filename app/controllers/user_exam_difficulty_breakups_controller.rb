class UserExamDifficultyBreakupsController < ApplicationController
  before_action :set_user_exam_difficulty_breakup, only: [:show, :edit, :update, :destroy]

  # GET /user_exam_difficulty_breakups
  # GET /user_exam_difficulty_breakups.json
  def index
    @user_exam_difficulty_breakups = UserExamDifficultyBreakup.all
  end

  # GET /user_exam_difficulty_breakups/1
  # GET /user_exam_difficulty_breakups/1.json
  def show
  end

  # GET /user_exam_difficulty_breakups/new
  def new
    @user_exam_difficulty_breakup = UserExamDifficultyBreakup.new
  end

  # GET /user_exam_difficulty_breakups/1/edit
  def edit
  end

  # POST /user_exam_difficulty_breakups
  # POST /user_exam_difficulty_breakups.json
  def create
    @user_exam_difficulty_breakup = UserExamDifficultyBreakup.new(user_exam_difficulty_breakup_params)

    respond_to do |format|
      if @user_exam_difficulty_breakup.save
        format.html { redirect_to @user_exam_difficulty_breakup, notice: 'User exam difficulty breakup was successfully created.' }
        format.json { render :show, status: :created, location: @user_exam_difficulty_breakup }
      else
        format.html { render :new }
        format.json { render json: @user_exam_difficulty_breakup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_exam_difficulty_breakups/1
  # PATCH/PUT /user_exam_difficulty_breakups/1.json
  def update
    respond_to do |format|
      if @user_exam_difficulty_breakup.update(user_exam_difficulty_breakup_params)
        format.html { redirect_to @user_exam_difficulty_breakup, notice: 'User exam difficulty breakup was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_exam_difficulty_breakup }
      else
        format.html { render :edit }
        format.json { render json: @user_exam_difficulty_breakup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_exam_difficulty_breakups/1
  # DELETE /user_exam_difficulty_breakups/1.json
  def destroy
    @user_exam_difficulty_breakup.destroy
    respond_to do |format|
      format.html { redirect_to user_exam_difficulty_breakups_url, notice: 'User exam difficulty breakup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_exam_difficulty_breakup
      @user_exam_difficulty_breakup = UserExamDifficultyBreakup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_exam_difficulty_breakup_params
      params.require(:user_exam_difficulty_breakup).permit(:correct, :incorrect, :attempted, :exam_attempt_id, :difficulty_level_id)
    end
end
