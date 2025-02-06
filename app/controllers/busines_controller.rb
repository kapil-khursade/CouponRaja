class BusinesController < ApplicationController
  before_action :set_busine, only: %i[ show edit update destroy ]

  # GET /busines or /busines.json
  def index
    @busines = current_user.busine
  end

  # GET /busines/1 or /busines/1.json
  def show
    @config_obj_1 = [
                    "gstin"
                    ]
    @config_obj_2 = [
                    "valid_check_status"
                    ]
    if @busine.valid_check_status == "valid_gstin"
      @config_obj_1 = [
                        "gstin",
                        "trade_name",
                        "legal_name",
                        "constitution",
                        "status",
                        "registration_date",
                        "last_update",
                        "taxpayer_type", "nature_of_business", "principal_nature_of_business", "filing_frequency",
                        "cancellation_date"
                        ]

        @config_obj_2 = [
                        "valid_check_status", "state_jurisdiction", "state_jurisdiction_code",
                        "center_jurisdiction", "center_jurisdiction_code",
                        "building_number",
                        "building_name", "street", "location", "district", "state_code", "pin_code",
                        "latitude", "longitude"
                        ]
    end
  end

  # GET /busines/new
  def new
    @busine = Busine.new
  end

  # GET /busines/1/edit
  def edit
  end

  # POST /busines or /busines.json
  def create
    @busine = Busine.new(busine_params)
    @busine.user_id = current_user.id

    respond_to do |format|
      if @busine.save
        format.html { redirect_to @busine, notice: "Busine was successfully created." }
        format.json { render :show, status: :created, location: @busine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @busine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /busines/1 or /busines/1.json
  def update
    respond_to do |format|
      if @busine.update(busine_params)
        format.html { redirect_to @busine, notice: "Busine was successfully updated." }
        format.json { render :show, status: :ok, location: @busine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @busine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /busines/1 or /busines/1.json
  def destroy
    @busine.destroy!

    respond_to do |format|
      format.html { redirect_to busines_path, status: :see_other, notice: "Busine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_busine
      @busine = Busine.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def verify_mobile_no_params
      params.require(:busine).permit(:gstin)
    end
end
