require 'csv'
require 'pry'

task :import_energy_data => :environment do
  path = "#{Rails.root}/db/data/groningen_data/*"
  Dir[path].each do |file_path|
    uid = file_path.match(/6.*\./)[0]
    household = Household.find_or_create_by!(uid: uid)
    options = { headers: :first_row, header_converters: :symbol }
    house_data_count = Hash.new(0)
    CSV.foreach(file_path, options) do |row|
      returned_energy = row[:b_consumption]&.to_f
      house_data_count[returned_energy] += 1
      if returned_energy.try(:>, 0.0) && house_data_count[returned_energy] < 20
        ed = EnergyDatum.create({
          returned_energy: returned_energy,
          datetime: DateTime.parse(row[:utc_timestamp]),
          household: household
        })
      end
    end
    house_data_count.each do |key, value|
      if value >= 20
        household.energy_data.where(returned_energy: key).destroy_all
      end
    end
    household.set_peak_curve
    puts "Added #{household.address}"
  end
end


task :clean_bad_addresses => :environment do
  Household.all.select do |h|
    if h.address.include?("..")
      h.update(address: h.send(:rand_address))
    end
  end
end







