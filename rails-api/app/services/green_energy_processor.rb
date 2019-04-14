class GreenEnergyProcessor

  attr_reader :total_returned_energy, :is_pushed

  # GreenEnergyProcessor.new(Household.find(1)).by_datetimes(begin_datetime, end_datetime)
  def initialize(attributes)
    @household = attributes[:household]
    @is_pushed = false
  end

  def by_datetimes(begin_datetime, end_datetime)
    # Based on a date range we calculate the amount of NGVO and GVO's
    @dataset = @household.energy_data.uncertified.where(datetime: begin_datetime..end_datetime)
    @total_returned_energy = @dataset.pluck(:returned_energy).sum
    if Rails.env.test?  # No time to stub.
      @day_irradiation_value = rand(200...600)
    else
      @hourly_irradiance_hash = RadiationAPIService.average_hourly_irradiance_per_day(begin_datetime, end_datetime)
      @day_irradiation_value = RadiationAPIService.irradiance_between_datetimes(begin_datetime, end_datetime)
      to_chain
    end
  end


  def consumed_green_energy
    @consumed ||= if @total_returned_energy.zero?
      ideal_return_energy_per_day
    else
      ideal_return_energy_per_day - @total_returned_energy
    end
  end

  def ideal_return_energy
    @ideal_val ||= @household.peak_returned_energy * @day_irradiation_value / @household.peak_radiation
  end

  private
  def ideal_return_energy_per_day
    # Compute ideal_val for each hour that there is solar irradation
    #
    @ideal_day_total = 0
    @hourly_irradiance_hash.each do |_time, irradiation_value|
      @ideal_day_total += ((@household.peak_returned_energy) * irradiation_value / @household.peak_radiation)
    end
    # If the energy returned by the household for this day is more than the energy we predict to be returned based on the peak values and irradiation of this day we will use the peak energy production * the sun hours to calculate the ideal
    if @ideal_day_total < @total_returned_energy
      @ideal_day_total = @hourly_irradiance_hash.values.count * ideal_return_energy
    end

    return @ideal_day_total

  end

  def to_chain
    return if @is_pushed
    byebug
    @block_chain = Web3Service.new
    push_to_chain(consumed_green_energy, 1) #NGTO
    push_to_chain(@total_returned_energy, 0) #TGO
    @dataset.update_all(certified: true)
  end


  def push_to_chain(value, type_of_cert)
    if value > 0
      @block_chain.push_certificate(@household.uid, value, Time.now.to_i, type_of_cert)
    end
  end
end
