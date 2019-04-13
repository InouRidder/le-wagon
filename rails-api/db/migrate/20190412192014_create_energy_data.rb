class CreateEnergyData < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_data do |t|
      t.datetime :datetime
      t.integer :returned_energy
      t.string :type
      t.references :household

      t.timestamps
    end
  end
end
