class ChangeColsforMeds < ActiveRecord::Migration
  def self.up
    remove_column :reminders, :name
    remove_column :reminders, :amount
    add_column :reminders, :meds, :string
  end

  def self.down
    add_column :reminders, :name, :string
    add_column :reminders, :amount, :string
    remove_column :reminders, :meds
  end
end
