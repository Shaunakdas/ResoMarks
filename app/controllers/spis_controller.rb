class SpisController < ApplicationController
  before_action :set_spi, only: [:show, :edit, :update, :destroy]

  # GET /spis
  # GET /spis.json
  def index
    @spis = Spi.all
  end

  # GET /spis/1
  # GET /spis/1.json
  def show
  end

  # GET /spis/new
  def new
    @spi = Spi.new
  end

  # GET /spis/1/edit
  def edit
  end

  # POST /spis
  # POST /spis.json
  def create
    @spi = Spi.new(spi_params)

    respond_to do |format|
      if @spi.save
        format.html { redirect_to @spi, notice: 'Spi was successfully created.' }
        format.json { render :show, status: :created, location: @spi }
      else
        format.html { render :new }
        format.json { render json: @spi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spis/1
  # PATCH/PUT /spis/1.json
  def update
    respond_to do |format|
      if @spi.update(spi_params)
        format.html { redirect_to @spi, notice: 'Spi was successfully updated.' }
        format.json { render :show, status: :ok, location: @spi }
      else
        format.html { render :edit }
        format.json { render json: @spi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spis/1
  # DELETE /spis/1.json
  def destroy
    @spi.destroy
    respond_to do |format|
      format.html { redirect_to spis_url, notice: 'Spi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spi
      @spi = Spi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spi_params
      params.require(:spi).permit(:value, :exam_attempt_id, :target_exam_id)
    end
end
