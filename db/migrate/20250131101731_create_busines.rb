class CreateBusines < ActiveRecord::Migration[8.0]
  def change
    create_table :busines do |t|
      t.references :user, null: false, foreign_key: true
      t.string :gstin, null: false, index: true
      t.integer :valid_check_status, null: false, default: 0
      t.string :validation_job_result
      t.string :trade_name
      t.string :legal_name
      t.string :constitution
      t.string :status
      t.date :registration_date
      t.string :last_update
      t.string :taxpayer_type
      t.string :state_jurisdiction
      t.string :state_jurisdiction_code
      t.string :center_jurisdiction
      t.string :center_jurisdiction_code
      t.string :filing_frequency
      t.string :nature_of_business, array: true, default: []
      t.string :principal_nature_of_business
      t.string :building_number
      t.string :building_name
      t.string :street
      t.string :location
      t.string :district
      t.string :state_code
      t.string :pin_code
      t.string :latitude
      t.string :longitude
      t.date :cancellation_date

      t.timestamps
    end
  end
end
