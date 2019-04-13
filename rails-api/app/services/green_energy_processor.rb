class GreenEnergyProcessor

  attr_reader :total_returned_energy

  # GreenEnergyProcessor.new(Household.find(1)).by_datetimes(begin_datetime, end_datetime)

  def initialize(household)
    @household = attributes[:household]
    @is_pushed = false
  end

  def by_datetimes(begin_datetime, end_datetime)
    # Based on a date range we calculate the amount of NGVO and GVO's
    @day_irradiation_value = RadiationAPIService.irradiance_between_datetimes(begin_datetime, end_datetime)
    @dataset = @household.energy_data.uncertified.where(datetime: begin_datetime..end_datetime)
    @total_returned_energy = @dataset.pluck(:returned_energy).sum
    to_chain
  end

  def consumed_green_energy
    @consumed ||= if @total_returned_energy.zero?
      ideal_return_energy
    else
      ideal_return_energy - @total_returned_energy
    end
  end

  def ideal_return_energy
    @ideal_val ||= @household.peak_returned_energy * @day_irradiation_value / @household.peak_radiation
  end

  def to_chain
    return if @is_pushed
    @block_chain = Web3Service.new
    push_to_chain(consumed_green_energy, 'NTGO')
    push_to_chain(@total_returned_energy, 'TGO')
    @dataset.update_all(certified: true)
  end

  private

  def push_to_chain(value, type_of_cert)
    if value > 0
      @block_chain.push_certificate(@household.uid, value, Time.now, type_of_cert)
    end
  end
end
