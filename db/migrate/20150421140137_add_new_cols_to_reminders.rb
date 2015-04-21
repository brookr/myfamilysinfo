class AddNewColsToReminders < ActiveRecord::Migration
  def self.up
    rename_column :reminders, :date, :datetime
    remove_column :reminders, :data
    add_column :reminders, :amount, :string
    add_column :reminders, :temperature, :string
    add_column :reminders, :height, :string
    add_column :reminders, :weight, :string
    add_column :reminders, :description, :string
  end

  def self.down
    rename_column :reminders, :datetime, :date
    add_column :reminders, :data, :string
    remove_column :reminders, :amount
    remove_column :reminders, :temperature
    remove_column :reminders, :height
    remove_column :reminders, :weight
    remove_column :reminders, :description
  end
end
