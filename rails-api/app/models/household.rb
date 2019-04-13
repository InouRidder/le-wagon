class Household < ApplicationRecord

  validates :uid, uniqueness: true, presence: true
  has_many :energy_data

  def self.find_or_create(attributes)
    Household.find_by(uid: attributes[:uid]) || Household.create(uid: attributes[:uid])
  end

  def set_peak_curve
    OptimalProdudctionEstimator.new(household: @household)
  end

  def returned_energy_per_day(day)
    energy_data.where { |datum| datum.datetime.yday == day }
    # energy datum are always positive returns.
    # Return all energy delivered back to the grid for a given day.
  end
end
