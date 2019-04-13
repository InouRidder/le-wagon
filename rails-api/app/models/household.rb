class Household < ApplicationRecord

  validates :uid, uniqueness: true, presence: true
  has_many :energy_data

  after_create :set_address
  geocoded_by :address
  after_validation :geocode

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

  private

  def set_address
    self.update(address: "Groningen #{rand_address}")
  end

  def rand_address
    ["Grote Markt #{rand(1..20)}", "Herestraat #{rand(1..76)}", "Oosterstraat #{rand(1..58)}", "Kraneweg #{20..119}"].sample
  end
end
