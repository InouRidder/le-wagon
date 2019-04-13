class GuaranteeOfOriginService
  def initialize(household, data)
    @household = household
    @day_peak_production = DayProductionEstimator.estimate(@household, household.peak_curve)
  end

  def consumed_green_energy

  end

  def returned_green_energy

  end

end
