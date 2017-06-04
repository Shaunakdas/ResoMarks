class UserPhoneNumbersController < ApplicationController
  before_action :set_user_phone_number, only: [:show, :edit, :update, :destroy]

  # GET /user_phone_numbers
  # GET /user_phone_numbers.json
  def index
    @user_phone_numbers = UserPhoneNumber.all
  end

  # GET /user_phone_numbers/1
  # GET /user_phone_numbers/1.json
  def show
  end

  # GET /user_phone_numbers/new
  def new
    @user_phone_number = UserPhoneNumber.new
  end

  # GET /user_phone_numbers/1/edit
  def edit
  end

  # POST /user_phone_numbers
  # POST /user_phone_numbers.json
  def create
    @user_phone_number = UserPhoneNumber.new(user_phone_number_params)

    respond_to do |format|
      if @user_phone_number.save
        format.html { redirect_to @user_phone_number, notice: 'User phone number was successfully created.' }
        format.json { render :show, status: :created, location: @user_phone_number }
      else
        format.html { render :new }
        format.json { render json: @user_phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_phone_numbers/1
  # PATCH/PUT /user_phone_numbers/1.json
  def update
    respond_to do |format|
      if @user_phone_number.update(user_phone_number_params)
        format.html { redirect_to @user_phone_number, notice: 'User phone number was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_phone_number }
      else
        format.html { render :edit }
        format.json { render json: @user_phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_phone_numbers/1
  # DELETE /user_phone_numbers/1.json
  def destroy
    @user_phone_number.destroy
    respond_to do |format|
      format.html { redirect_to user_phone_numbers_url, notice: 'User phone number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_phone_number
      @user_phone_number = UserPhoneNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_phone_number_params
      params.require(:user_phone_number).permit(:number, :user_id)
    end
end
