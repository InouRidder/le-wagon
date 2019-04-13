class RadiationAPIService
  class << self
    def self.weather_between_datetimes(begin_datetime, end_datetime, household)
      # url = "https://developer.nrel.gov/api/solar/solar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
      # response = HTTParty.get(url)
      # p response
      return 404
    end

    def self.weather_by_datetime(datetime)
      return 340
    end
  end
end
