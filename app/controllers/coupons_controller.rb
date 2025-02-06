class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[ show edit update destroy ]

  # GET /coupons or /coupons.json
  def index
    @coupons = current_user.coupon
  end

  # GET /coupons/1 or /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
    @businesses = current_user.busine.validated
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons or /coupons.json
  def create
    @quantity = params[:coupon][:quantity].to_i
    @quantity = 1 if @quantity.zero? # Default to 1 if quantity is nil or 0

    @coupons = []
    @quantity.times do
      @coupon = Coupon.new(coupon_params)
      @coupon.user = current_user
      @coupons << @coupon if @coupon.save
    end

    if @coupons.any?
      redirect_to coupons_path, notice: "#{@coupons.count} coupon(s) were successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1 or /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: "Coupon was successfully updated." }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1 or /coupons/1.json
  def destroy
    @coupon.destroy!

    respond_to do |format|
      format.html { redirect_to coupons_path, status: :see_other, notice: "Coupon was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_status
    @coupon = Coupon.find(params[:id])
    @coupon.update(active_status: !@coupon.active_status)

    respond_to do |format|
      format.json { render json: { success: true, active_status: @coupon.active_status } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def coupon_params
      params.require(:coupon).permit(:busine_id, :coupon_type, :value, :valid_up_to)
    end
end
