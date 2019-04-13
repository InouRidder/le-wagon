class RadiationAPIService
  def initialize(household)
    @household = household
  end

  def by_datetime(datetime)
  end

  def by_day(day)
  end

  def by_week(week)
  end

  def by_month(month)
  end

  def call
    url = "https://developer.nrel.gov/api/solar/solar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
    response = HTTParty.get(url)
    p response
  end
end
