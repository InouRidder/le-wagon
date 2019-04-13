class Household < ApplicationRecord

  validates :uid, uniqueness: true, presence: true
  has_many :energy_data

  after_create :set_address
  geocoded_by :address
  after_validation :geocode

  def self.find_or_create(attributes)
    Household.find_by(uid: attributes[:uid]) || Household.create(uid: attributes[:uid])
  end

  def set_optimal_production
    OptimalProductionEstimator.new(self)
  end

  def highest_energy_datum
    all_data = self.energy_data
    all_data.find_by(returned_energy: all_data.pluck(:returned_energy).max)
  end

  private

  def set_address
    self.update(
      address: "Groningen #{rand_address}"
    )
  end

  def rand_address
    ["Grote Markt #{rand(1..20)}", "Herestraat #{rand(1..76)}", "Oosterstraat #{rand(1..58)}", "Kraneweg #{rand(20..119)}"].sample
  end
end
