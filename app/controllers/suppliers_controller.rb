class SuppliersController < ApplicationController
  before_action :authenticate_merchant!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
     if params[:highlight].blank?
			@suppliers = Supplier.where(draft: false).order("created_at DESC")
		else
			@highlight_id = Highlight.find_by(name: params[:highlight]).id
			@suppliers = Supplier.where(highlight_id: @highlight_id).order("created_at DESC")
		end
    @search = Supplier.ransack(params[:q])
    @search.sorts = 'created_at DESC' if @search.sorts.empty?
    @suppliers = @search.result.where(draft: false)
    @qualifying_type = QualifyingType.all
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @current_merchant = current_merchant
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = current_merchant.suppliers.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
       @supplier = Supplier.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:business_name, :general_contact_number, :general_email, :operating_address, :facebook, :instagram, :website, :preferred_contact, :preferred_order_method, :question_1, :question_2, :question_3, :question_4, :question_5, :delivery_url, :expiry_date, :friends_terms, :merchant_id, :draft, :verified, :logo, :featured_image, :image, :image_2, :image_3, :image_4, :document_1, :document_2, :document_3, :document_4, :friends_reward_id, :region_id, :location_id, :supplier_type_id, :price_range_id, :qualifying_type_id, food_type_ids: [], supplier_highlight_ids: [] )
    end
end
