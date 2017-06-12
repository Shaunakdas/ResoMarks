class ScoreNamesController < ApplicationController
  before_action :set_score_name, only: [:show, :edit, :update, :destroy]

  # GET /score_names
  # GET /score_names.json
  def index
    @score_names = ScoreName.all
  end

  # GET /score_names/1
  # GET /score_names/1.json
  def show
  end

  # GET /score_names/new
  def new
    @score_name = ScoreName.new
  end

  # GET /score_names/1/edit
  def edit
  end

  # POST /score_names
  # POST /score_names.json
  def create
    @score_name = ScoreName.new(score_name_params)

    respond_to do |format|
      if @score_name.save
        format.html { redirect_to @score_name, notice: 'Score name was successfully created.' }
        format.json { render :show, status: :created, location: @score_name }
      else
        format.html { render :new }
        format.json { render json: @score_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /score_names/1
  # PATCH/PUT /score_names/1.json
  def update
    respond_to do |format|
      if @score_name.update(score_name_params)
        format.html { redirect_to @score_name, notice: 'Score name was successfully updated.' }
        format.json { render :show, status: :ok, location: @score_name }
      else
        format.html { render :edit }
        format.json { render json: @score_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /score_names/1
  # DELETE /score_names/1.json
  def destroy
    @score_name.destroy
    respond_to do |format|
      format.html { redirect_to score_names_url, notice: 'Score name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_name
      @score_name = ScoreName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_name_params
      params.require(:score_name).permit(:display_text, :min, :min_include, :max, :max_include)
    end
end
