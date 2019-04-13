require 'csv'


task :import_energy_data => :environment do

  ImportEnergyData.new
end

class ImportEnergyData
  include Rake::DSL
  def initialize
    path = "#{Rails.root}/db/data/groningen_data/*"
    Dir[path].each do |file_path|
      household = fetch_house_data(file_path)
      household.set_optimal_production
    end
  end

  def clean_house_data(house_data_count, household)
    # Remove bad values (still 20 saved if present)
    house_data_count.each do |key, value|
      if value >= 20
        household.energy_data.where(returned_energy: key).destroy_all
      end
    end
  end

  def parse_csv(file_path)
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(file_path, options) do |row|
      yield(row)
    end
  end

  def energy_in_bounds?(returned_energy, house_data_count)
      # Not saving if there is no returned energy
      # If the specific returned value has been counted over 20 times (a bias value) don't save it.
    returned_energy.try(:>, 0.0) && house_data_count[returned_energy] < 20
  end

  def create_household(file_path)
    uid = file_path.match(/6.*\./)[0]
    Household.find_or_create_by!(uid: uid)
  end


  def fetch_house_data(file_path)
    household = create_household(file_path)
    house_data_count = Hash.new(0)
    parse_csv(file_path) do |row|
      returned_energy = row[:b_consumption]&.to_f
      house_data_count[returned_energy] += 1
      if energy_in_bounds?(returned_energy, house_data_count)
        EnergyDatum.create({
          returned_energy: returned_energy,
          datetime: DateTime.parse(row[:utc_timestamp]),
          household: household
        })
      end
    end
    # clean_house_data(house_data_count, household)
    household
  end
end
