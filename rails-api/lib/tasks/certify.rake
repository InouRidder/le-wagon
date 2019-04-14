task :certify_green_energy => :environment do
  house = Household.find_by(uid: 60000004)
  processor = GreenEnergyProcessor.new(household: house)
  date = DateTime.new(2017,5,21)
  processor.by_datetimes(date.beginning_of_day, date.end_of_day)
end
