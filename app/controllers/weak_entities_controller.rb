class WeakEntitiesController < ApplicationController
  before_action :set_weak_entity, only: [:show, :edit, :update, :destroy]

  # GET /weak_entities
  # GET /weak_entities.json
  def index
    @weak_entities = WeakEntity.all
  end

  # GET /weak_entities/1
  # GET /weak_entities/1.json
  def show
  end

  # GET /weak_entities/new
  def new
    @weak_entity = WeakEntity.new
  end

  # GET /weak_entities/1/edit
  def edit
  end

  # POST /weak_entities
  # POST /weak_entities.json
  def create
    @weak_entity = WeakEntity.new(weak_entity_params)

    respond_to do |format|
      if @weak_entity.save
        format.html { redirect_to @weak_entity, notice: 'Weak entity was successfully created.' }
        format.json { render :show, status: :created, location: @weak_entity }
      else
        format.html { render :new }
        format.json { render json: @weak_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weak_entities/1
  # PATCH/PUT /weak_entities/1.json
  def update
    respond_to do |format|
      if @weak_entity.update(weak_entity_params)
        format.html { redirect_to @weak_entity, notice: 'Weak entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @weak_entity }
      else
        format.html { render :edit }
        format.json { render json: @weak_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weak_entities/1
  # DELETE /weak_entities/1.json
  def destroy
    @weak_entity.destroy
    respond_to do |format|
      format.html { redirect_to weak_entities_url, notice: 'Weak entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weak_entity
      @weak_entity = WeakEntity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weak_entity_params
      params.require(:weak_entity).permit(:exam_attempt_id, :entity_id, :entity_type)
    end
end
