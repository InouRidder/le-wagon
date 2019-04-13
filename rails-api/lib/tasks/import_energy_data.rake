require 'csv'
require 'pry'

task :import_energy_data => :environment do
  path = "#{Rails.root}/db/data/groningen_data/*"
  Dir[path].each do |file_path|
    uid = file_path.match(/6.*\./)[0]
    household = Household.find_or_create_by!(uid: uid)
    p household
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(file_path, options) do |row|
      returned_energy = row[:b_consumption]&.to_f
      if returned_energy.try(:>, 0.0)
        ed = EnergyDatum.create({
          returned_energy: returned_energy,
          datetime: DateTime.parse(row[:utc_timestamp]),
          household: household
        })
        p ed
      end
    end
  end
end


task :count_houses => :environment do
  path = "#{Rails.root}/db/data/groningen_data/*"
  count = 0
  Dir[path].each do |file_path|

    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(file_path, options) do |row|
      count += 1 if row[:having_solar] == "True"
      break
    end
  end
  puts count
end
