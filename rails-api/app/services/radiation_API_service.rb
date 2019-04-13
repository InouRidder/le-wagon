class RadiationAPIService
  class << self
    def weather_between_datetimes(begin_datetime, end_datetime)
      # url = "https://developer.nrel.gov/api/solar/solar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
      # response = HTTParty.get(url)
      [404, 400, 2, 3, 323, 345, 123, 120].sample
    end

    def weather_by_datetime(datetime)
      [404, 400, 2, 3, 233, 345, 123, 120].sample
    end
  end
end
