class AddAddressToHouseholds < ActiveRecord::Migration[5.2]
  def change
    add_column :households, :address, :string
    add_column :households, :latitude, :float
    add_column :households, :longitude, :float
  end
end
