class OptimalProductionEstimator
  def initialize(attributes)
    @household = attributes[:household]
    @data = @household.energy_data
    analyze
  end

  def analyze
    max_high = @data.pluck(:returned_energy).max
    max_low = @data.pluck(:returned_energy).min

    @data.each do |set|

    end
  end
end
