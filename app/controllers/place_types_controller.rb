class PlaceTypesController < ApplicationController
  before_filter :is_admin?, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_place_type, only: [:show, :edit, :update, :destroy]

  # GET /place_types
  # GET /place_types.json
  def index
    @place_types = PlaceType.all
  end

  # GET /place_types/1
  # GET /place_types/1.json
  def show
  end

  # GET /place_types/new
  def new
    @place_type = PlaceType.new
  end

  # GET /place_types/1/edit
  def edit
  end

  # POST /place_types
  # POST /place_types.json
  def create
    @place_type = PlaceType.new(place_type_params)

    respond_to do |format|
      if @place_type.save
        format.html { redirect_to place_types_path, notice: 'Place type was successfully created.' }
        format.json { render :show, status: :created, location: @place_type }
        format.js
      else
        format.html { render :new }
        format.json { render json: @place_type.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /place_types/1
  # PATCH/PUT /place_types/1.json
  def update
    respond_to do |format|
      if @place_type.update(place_type_params)
        format.html { redirect_to @place_type, notice: 'Place type was successfully updated.' }
        format.json { render :show, status: :ok, location: @place_type }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @place_type.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /place_types/1
  # DELETE /place_types/1.json
  def destroy
    @place_type.destroy
    respond_to do |format|
      format.html { redirect_to place_types_url, notice: 'Place type was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  def is_admin?
  unless current_merchant && current_merchant.admin?
   render "layouts/unauthorised"
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place_type
      @place_type = PlaceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_type_params
      params.require(:place_type).permit(:name, :icon)
    end
end
