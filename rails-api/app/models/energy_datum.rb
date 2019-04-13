class EnergyDatum < ApplicationRecord
  belongs_to :household

  # scope :per_day, -> (day) {}
end
