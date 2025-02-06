class AddNameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string, default: ""
    add_column :users, :mobile_no_verified, :boolean, default: false
    add_column :users, :mobile_no_have_whatsapp, :boolean, default: false
  end
end
