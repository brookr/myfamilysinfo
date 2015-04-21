class ChangeKidDobToDateTime < ActiveRecord::Migration
  def change
    remove_column :kids, :dob
    add_column :kids, :dob, :date
  end
end
