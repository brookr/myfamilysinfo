class AddColumnsToKids < ActiveRecord::Migration
  def change
    change_table :kids do |t|
      t.column :dob, :date
      t.column :nurse_phone, :string
      t.column :insurance_id, :string
    end
  end
end
