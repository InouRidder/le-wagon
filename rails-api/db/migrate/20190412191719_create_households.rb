class CreateHouseholds < ActiveRecord::Migration[5.2]
  def change
    create_table :households do |t|
      t.integer :uid
      t.jsonb :peak_production_curve
      t.integer :average_min_consumption
      t.boolean :solar

      t.timestamps
    end
  end
end
