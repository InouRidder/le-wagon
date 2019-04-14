class RadiationAPIService
  @@irradiance_peaks_per_month = {
    "january" => 193,
    "february" => 299,
    "march" => 456,
    "april" => 618,
    "may" => 599,
    "june" => 564,
    "july" => 559,
    "august" => 542,
    "september" => 461,
    "october" => 352,
    "november" => 219,
    "december" => 186,
  }

  @@hourly_irradiance_average_per_month = {
    "january" => 193,
    "february" => 299,
    "march" => 456,
    "april" => {
      "04:00" => 13,
      "05:00" => 83,
      "06:00" => 220,
      "07:00" => 367,
      "08:00" => 488,
      "09:00" => 592,
      "10:00" => 618,
      "11:00" => 608,
      "12:00" => 591,
      "13:00" => 502,
      "14:00" => 391,
      "15:00" => 247,
      "16:00" => 112,
      "17:00" => 22,
    },
    "may" => 599,
    "june" => 564,
    "july" => 559,
    "august" => 542,
    "september" => 461,
    "october" => 352,
    "november" => 219,
    "december" => 186,
  }

  class << self
    def average_hourly_irradiance_per_day(begin_datetime, end_datetime)
      # Return peak (or set of irradiance values) irradiance values based on beginning and end date
      # url = "https://developer.nrel.gov/api/solar/seaf78olar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
      # response = HTTParty.get(url)
      @@hourly_irradiance_average_per_month[begin_datetime.strftime("%B").downcase]
    end

    def irradiance_between_datetimes(begin_datetime, end_datetime)
      # Return peak (or set of irradiance values) irradiance values based on beginning and end date
      # url = "https://developer.nrel.gov/api/solar/seaf78olar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
      # response = HTTParty.get(url)
      @@irradiance_peaks_per_month[begin_datetime.strftime("%B").downcase]
    end

    def irradiance_by_datetime(datetime)
      # Return irradiance value b                 ased on the date of the highest WH peak.
      # Because we dont have access to daily or hourly specific irradiance values ->
      # we will return the highest irradiance value of an average day of a specific month.
      # url = "https://developer.nrel.gov/api/solar/solar_resource/v1.format?api_key=kUJgs2bV92fhQLV1eMGw89wTzfyFMLPpZv0DBxAg&lat=#{@household.latitude}&lng=#{@household.longitude}";
      # response = HTTParty.get(url)
      @@irradiance_peaks_per_month[datetime.strftime("%B").downcase]
    end
  end
end
