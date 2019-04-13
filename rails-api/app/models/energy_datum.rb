class EnergyDatum < ApplicationRecord
  belongs_to :household
  scope :uncertified, -> { where(certified: false) }
end
