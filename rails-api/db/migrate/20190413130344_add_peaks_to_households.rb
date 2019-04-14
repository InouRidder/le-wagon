class AddPeaksToHouseholds < ActiveRecord::Migration[5.2]
  def change
    add_column :households, :peak_radiation, :integer
    add_column :households, :peak_returned_energy, :integer
  end
end
