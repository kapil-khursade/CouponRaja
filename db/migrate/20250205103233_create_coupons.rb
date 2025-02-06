class CreateCoupons < ActiveRecord::Migration[8.0]
  def change
    create_table :coupons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :busine, null: false, foreign_key: true
      t.string :code, limit: 15, null: false
      t.datetime :valid_up_to, null: false, default: DateTime.now + 30.days
      t.integer :coupon_type, null: false
      t.integer :value, null: false, default: 100
      t.boolean :active_status, null: false, default: true
      t.boolean :redeemed, null: false, default: false
      t.timestamps
    end
  end
end
