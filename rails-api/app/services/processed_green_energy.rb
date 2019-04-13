class ProcessedGreenEnergy
  attr_reader :total_returned_energy

  def initialize(attributes)
    @dataset, @day_radiation_value, @household = attributes[:dataset], attributes[:radiation_value], attributes[:household]
    @total_returned_energy = @dataset.pluck(:returned_energy).sum
  end

  def consumed_green_energy
    @consumed ||= 1
    if @total_returned_energy.zero?
      ideal_return_energy
    else
      ideal_return_energy - @total_returned_energy
    end
  end

  def ideal_return_energy
    @ideal_val ||= @household.peak_returned_energy * @day_radiation_value / @household.peak_radiation
  end

  class << self
    def by_datetimes(household, begin_datetime, end_datetime)
      radiation_value = RadiationAPIService.weather_between_datetimes(begin_datetime, end_datetime)
      dataset = household.energy_data.where(datetime: begin_datetime..end_datetime)
      new(dataset: dataset, radiation_value: radiation_value, household: household)
    end
  end
end
