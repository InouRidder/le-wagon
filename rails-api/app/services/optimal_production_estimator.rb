class OptimalProductionEstimator
  def initialize(attributes)
    @household = attributes[:household]
    create_peak_curve
  end

  def create_peak_curve
    peak_curve = Hash.new(0)
    @household.energy_data.each do |datum|
      moment = datum.datetime.strftime('%H:%M') # example: "00:15"
      # Overwrite the value of hash for key (hour/minute) if the given value is higher than the current value
      peak_curve[moment] = datum[:returned_energy] if datum[:returned_energy] > peak_curve[moment]
    end
    @household.update(peak_production_curve: clean_peak_curve(peak_curve))
  end
end
