class Household < ApplicationRecord
  validates :uid, uniqueness: true, presence: true
  has_many :energy_data

  def self.find_or_create(attributes)
    Household.find_by(uid: attributes[:uid]) || Household.create(uid: attributes[:uid])
  end

  def create_peak_curve
    peak_curve = Hash.new(0)
    energy_data.each do |datum|
      moment = datum.datetime.strftime('%H:%M')
      peak_curve[moment] = datum[:returned_energy] if datum[:returned_energy] > peak_curve[moment]
    end
    self.update(peak_production_curve: peak_curve)
  end

  def returned_energy_per_day
    energy_data.group_by {|datum| datum.datetime.day  }.each do |datum|

    end
  end
end
