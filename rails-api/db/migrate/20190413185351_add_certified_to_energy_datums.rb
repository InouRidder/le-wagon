class AddCertifiedToEnergyDatums < ActiveRecord::Migration[5.2]
  def change
    add_column :energy_data, :certified, :boolean, default: false
  end
end
