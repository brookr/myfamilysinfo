class AddNewColsToReminders < ActiveRecord::Migration
  def self.up
    add_column :reminders, :type, :string
    add_column :reminders, :datetime, :datetime
    add_column :reminders, :amount, :string
    add_column :reminders, :temperature, :string
    add_column :reminders, :height, :string
    add_column :reminders, :weight, :string
    add_column :reminders, :description, :string
  end

  def self.down
    remove_column :reminders, :type
    remove_column :reminders, :datetime
    remove_column :reminders, :amount
    remove_column :reminders, :temperature
    remove_column :reminders, :height
    remove_column :reminders, :weight
    remove_column :reminders, :description
  end
end
