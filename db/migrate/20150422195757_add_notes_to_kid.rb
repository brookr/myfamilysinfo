class AddNotesToKid < ActiveRecord::Migration
  def change
    add_column :kids, :notes, :string
  end
end
