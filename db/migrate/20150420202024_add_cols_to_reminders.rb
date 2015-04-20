class AddColsToReminders < ActiveRecord::Migration
  def self.up
    add_column :reminders, :date, :string
    add_column :reminders, :type, :string
    add_column :reminders, :data, :string
  end

  def self.down
    remove_column :reminders, :date, :string
    remove_column :reminders, :type, :string
    remove_column :reminders, :data, :string
  end
end
