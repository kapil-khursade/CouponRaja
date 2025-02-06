# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_05_103233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "busines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "gstin", null: false
    t.integer "valid_check_status", default: 0, null: false
    t.string "validation_job_result"
    t.string "trade_name"
    t.string "legal_name"
    t.string "constitution"
    t.string "status"
    t.date "registration_date"
    t.string "last_update"
    t.string "taxpayer_type"
    t.string "state_jurisdiction"
    t.string "state_jurisdiction_code"
    t.string "center_jurisdiction"
    t.string "center_jurisdiction_code"
    t.string "filing_frequency"
    t.string "nature_of_business", default: [], array: true
    t.string "principal_nature_of_business"
    t.string "building_number"
    t.string "building_name"
    t.string "street"
    t.string "location"
    t.string "district"
    t.string "state_code"
    t.string "pin_code"
    t.string "latitude"
    t.string "longitude"
    t.date "cancellation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gstin"], name: "index_busines_on_gstin"
    t.index ["user_id"], name: "index_busines_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "busine_id", null: false
    t.string "code", limit: 15, null: false
    t.datetime "valid_up_to", default: "2025-03-07 23:52:51", null: false
    t.integer "coupon_type", null: false
    t.integer "value", default: 100, null: false
    t.boolean "active_status", default: true, null: false
    t.boolean "redeemed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["busine_id"], name: "index_coupons_on_busine_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dashboards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "mobile_no", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: ""
    t.boolean "mobile_no_verified", default: false
    t.boolean "mobile_no_have_whatsapp", default: false
    t.string "otp"
    t.datetime "otp_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "busines", "users"
  add_foreign_key "coupons", "busines"
  add_foreign_key "coupons", "users"
  add_foreign_key "dashboards", "users"
end
