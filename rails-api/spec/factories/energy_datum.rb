FactoryBot.define do
  factory :energy_datum do
    datetime { DateTime.now + ( Random.rand(20) / 48) }
    certified { false }
    association :household, factory: :household

    trait :with_energy do
      returned_energy { Random.rand(30..500) }
    end

    trait :without_energy do
      returned_energy { 0 }
    end

  end
end
