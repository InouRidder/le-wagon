class OptimalProductionEstimator
  def initialize(household)
    @household = household
    @highest_energy_datum = @household.highest_energy_datum
    if @household.energy_data.any?
      create_peak_curve
      find_peaks
    end
  end

  def create_peak_curve
    # this we can use for verification of true energy data - comparing curves
    peak_curve = Hash.new(0)
    @household.energy_data.each do |datum|
      moment = datum.datetime.strftime('%H:%M') # example: "00:15"
      # Overwrite the value of hash for key (hour/minute) if the given value is higher than the current value
      peak_curve[moment] = datum[:returned_energy] if datum[:returned_energy] > peak_curve[moment]
    end
    @household.update(peak_production_curve: peak_curve)
  end

  def find_peaks
    peak_radiation
    peak_returned_energy
  end

  def peak_radiation
    @household.update(peak_radiation: RadiationAPIService.irradiance_by_datetime(@highest_energy_datum.datetime))
  end

  def peak_returned_energy
    @household.update(peak_returned_energy: @highest_energy_datum.returned_energy)
  end

end
