class DashboardsController < ApplicationController
  # GET /dashboards or /dashboards.json
  def index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
end
