class UserGroupReferenceScoresController < ApplicationController
  before_action :set_user_group_reference_score, only: [:show, :edit, :update, :destroy]

  # GET /user_group_reference_scores
  # GET /user_group_reference_scores.json
  def index
    @user_group_reference_scores = UserGroupReferenceScore.all
  end

  # GET /user_group_reference_scores/1
  # GET /user_group_reference_scores/1.json
  def show
  end

  # GET /user_group_reference_scores/new
  def new
    @user_group_reference_score = UserGroupReferenceScore.new
  end

  # GET /user_group_reference_scores/1/edit
  def edit
  end

  # POST /user_group_reference_scores
  # POST /user_group_reference_scores.json
  def create
    @user_group_reference_score = UserGroupReferenceScore.new(user_group_reference_score_params)

    respond_to do |format|
      if @user_group_reference_score.save
        format.html { redirect_to @user_group_reference_score, notice: 'User group reference score was successfully created.' }
        format.json { render :show, status: :created, location: @user_group_reference_score }
      else
        format.html { render :new }
        format.json { render json: @user_group_reference_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_group_reference_scores/1
  # PATCH/PUT /user_group_reference_scores/1.json
  def update
    respond_to do |format|
      if @user_group_reference_score.update(user_group_reference_score_params)
        format.html { redirect_to @user_group_reference_score, notice: 'User group reference score was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group_reference_score }
      else
        format.html { render :edit }
        format.json { render json: @user_group_reference_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_group_reference_scores/1
  # DELETE /user_group_reference_scores/1.json
  def destroy
    @user_group_reference_score.destroy
    respond_to do |format|
      format.html { redirect_to user_group_reference_scores_url, notice: 'User group reference score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group_reference_score
      @user_group_reference_score = UserGroupReferenceScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_reference_score_params
      params.require(:user_group_reference_score).permit(:percentile, :rank, :user_entity_score_id, :group_id, :group_type, :entity_id, :entity_type)
    end
end
