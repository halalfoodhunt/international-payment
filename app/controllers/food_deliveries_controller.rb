class FoodDeliveriesController < ApplicationController
  before_action :authenticate_merchant!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_food_delivery, only: [:show, :edit, :update, :destroy]

  # GET /food_deliveries
  # GET /food_deliveries.json
  def index
     if params[:highlight].blank?
			@food_delivery = Food Delivery.where(draft: false).order("created_at DESC")
		else
			@highlight_id = Highlight.find_by(name: params[:highlight]).id
			@food_delivery = Food Delivery.where(highlight_id: @highlight_id).order("created_at DESC")
		end
    @search = Food Delivery.ransack(params[:q])
    @search.sorts = 'created_at DESC' if @search.sorts.empty?
    @food_delivery = @search.result.where(draft: false)
    @qualifying_type = QualifyingType.all
  end

  # GET /food_deliveries/1
  # GET /food_deliveries/1.json
  def show
  end

  # GET /food_deliveries/new
  def new
    @current_merchant = current_merchant
    @food_delivery = FoodDelivery.new
  end

  # GET /food_deliveries/1/edit
  def edit
  end

  # POST /food_deliveries
  # POST /food_deliveries.json
  def create
    @food_delivery = current_merchant.food_deliveries.new(food_delivery_params)

    respond_to do |format|
      if @food_delivery.save
        format.html { redirect_to @food_delivery, notice: 'Food delivery was successfully created.' }
        format.json { render :show, status: :created, location: @food_delivery }
      else
        format.html { render :new }
        format.json { render json: @food_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_deliveries/1
  # PATCH/PUT /food_deliveries/1.json
  def update
    respond_to do |format|
      if @food_delivery.update(food_delivery_params)
        format.html { redirect_to @food_delivery, notice: 'Food delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_delivery }
      else
        format.html { render :edit }
        format.json { render json: @food_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_deliveries/1
  # DELETE /food_deliveries/1.json
  def destroy
    @food_delivery.destroy
    respond_to do |format|
      format.html { redirect_to food_deliveries_url, notice: 'Food delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_delivery
       @food_delivery = Food Delivery.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_delivery_params
      params.require(:food_delivery).permit(:brand_name, :general_email, :contactable_hours, :general_contact_number, :website, :ordering_link, :facebook, :instagram, :question_1, :question_2, :question_3, :question_4, :question_5, :expiry_date, :friends_rewards_terms, :merchant_id, :draft, :verified, :friends_reward_id, :region_id, :cuisine_type_id, :food_delivery_type_id, :price_range_id, :qualifying_type_id)
    end
end
