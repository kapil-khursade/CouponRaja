require "net/http"
require "json"

class GstinValidationJob < ApplicationJob
  queue_as :default

  def perform(busines)
    return unless busines&.gstin.present?

    api_key = ENV["GSTIN_API_KEY"] # Fetch API key from environment
    return Rails.logger.error "Missing GSTIN API Key" unless api_key

    url = URI("http://sheet.gstincheck.co.in/check/#{api_key}/#{busines.gstin}")

    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if data["flag"] && data["message"] == "GSTIN  found."
      update_busines_record(busines, data["data"])
    else
      Rails.logger.error "GSTIN Validation Failed: #{data['message']}"
      busines.update(valid_check_status: :validation_failed, validation_job_result: data["message"])
    end
  end

  private

  def update_busines_record(busines, gstin_data)
    addr_data = gstin_data.dig("pradr", "addr") || {}

    busines.update(
      valid_check_status: :valid_gstin,
      validation_job_result: "GSTIN found.",
      trade_name: gstin_data["tradeNam"],
      legal_name: gstin_data["lgnm"],
      constitution: gstin_data["ctb"],
      status: gstin_data["sts"],
      registration_date: parse_date(gstin_data["rgdt"]),
      last_update: gstin_data["lstupdt"],
      taxpayer_type: gstin_data["dty"],
      state_jurisdiction: gstin_data["stj"],
      state_jurisdiction_code: gstin_data["stjCd"],
      center_jurisdiction: gstin_data["ctj"],
      center_jurisdiction_code: gstin_data["ctjCd"],
      filing_frequency: gstin_data["frequencyType"],
      nature_of_business: gstin_data["nba"],
      principal_nature_of_business: gstin_data.dig("pradr", "ntr"),
      building_number: addr_data["bno"],
      building_name: addr_data["bnm"],
      street: addr_data["st"],
      location: addr_data["loc"],
      district: addr_data["dst"],
      state_code: addr_data["stcd"],
      pin_code: addr_data["pncd"],
      latitude: addr_data["lt"],
      longitude: addr_data["lg"],
      cancellation_date: parse_date(gstin_data["cxdt"])
    )

    Rails.logger.info "Updated Busines record for GSTIN: #{busines.gstin}"
  end

  def parse_date(date_string)
    Date.parse(date_string) rescue nil
  end
end
