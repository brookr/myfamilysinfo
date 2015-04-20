class AddColsToKids < ActiveRecord::Migration
  def self.up
    add_column :kids, :dob, :string
    add_column :kids, :insurance_id, :string
    add_column :kids, :nurse_phone, :string
  end

  def self.down
    remove_column :kids, :dob, :string
    remove_column :kids, :insurance_id, :string
    remove_column :kids, :nurse_phone, :string
  end
end
