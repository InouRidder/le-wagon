FactoryBot.define do
  factory :household do
    uid { Random.rand(100..1000) }
    peak_radiation { 403 }
    peak_returned_energy { 600 }

    trait :with_energy_data do
      after(:create) do |household|
        10.times do
          create(:energy_datum, :with_energy, household: household)
        end
      end
    end

    trait :without_energy_data do
      after(:create) do |household|
        10.times do
          create(:energy_datum, :without_energy, household: household)
        end
      end
    end

  end
end
