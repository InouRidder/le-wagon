RSpec.describe GreenEnergyProcessor do
  describe "#initialize" do
    let(:no_energy_household) { create(:household, :without_energy_data) }
    let(:household) { create(:household, :with_energy_data) }


    it "sets initial values" do
      processor = GreenEnergyProcessor.new(household: household)

      expect(processor.is_pushed).to eq(false)
      expect(processor.instance_variable_get('@household')).not_to eq(nil)
    end
  end

  describe '#total_returned_energy' do
    let(:no_energy_household) { create(:household, :without_energy_data) }
    let(:household) { create(:household, :with_energy_data) }

    it "returns 0 if no energy was put back to the grid" do
      processor = GreenEnergyProcessor.new(household: no_energy_household)
      processor.by_datetimes(household.energy_data.first.datetime, household.energy_data.last.datetime)

      expect(processor.total_returned_energy).to eq(0)
    end

    it "can calculate total used energy" do
      processor = GreenEnergyProcessor.new(household: household)
      processor.by_datetimes(household.energy_data.first.datetime, household.energy_data.last.datetime)
      expect(processor.total_returned_energy).to eq(household.energy_data.uncertified.pluck(:returned_energy).sum)
    end
  end

  describe '#ideal_return_energy' do
    let(:household) { create(:household, :with_energy_data) }
    it "can calculate returned green energy" do
      processor = GreenEnergyProcessor.new(household: household)
      processor.by_datetimes(household.energy_data.first.datetime, household.energy_data.last.datetime)

      expect(processor.ideal_return_energy).to eq(household.peak_returned_energy * processor.instance_variable_get('@day_irradiation_value') / household.peak_radiation)
    end
  end

  describe '#consumed_green_energy' do
    let(:household) { create(:household, :with_energy_data) }
    it "it calculates total consumed green energy" do
      processor = GreenEnergyProcessor.new(household: household)
      processor.by_datetimes(household.energy_data.first.datetime, household.energy_data.last.datetime)

      expect(processor.consumed_green_energy).to eq(processor.ideal_return_energy - processor.total_returned_energy)
    end
  end
end
