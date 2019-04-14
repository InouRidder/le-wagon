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
    "january" => {
      "07:00" => 19,
      "08:00" => 108,
      "09:00" => 142,
      "10:00" => 193,
      "11:00" => 185,
      "12:00" => 162,
      "13:00" => 124,
      "14:00" => 72,
      "15:00" => 3,
    },
    "february" => {
      "06:00" => 8,
      "07:00" => 100,
      "08:00" => 175,
      "09:00" => 245,
      "10:00" => 287,
      "11:00" => 299,
      "12:00" => 274,
      "13:00" => 223,
      "14:00" => 139,
      "15:00" => 68,
      "16:00" => 1,
    },
    "march" => {
      "05:00" => 12,
      "06:00" => 100,
      "07:00" => 232,
      "08:00" => 346,
      "09:00" => 424,
      "10:00" => 454,
      "11:00" => 456,
      "12:00" => 428,
      "13:00" => 369,
      "14:00" => 279,
      "15:00" => 171,
      "16:00" => 53,
      "17:00" => 1,
    },
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
    "may" => {
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
    "june" => {
      "03:00" => 11,
      "04:00" => 48,
      "05:00" => 135,
      "06:00" => 279,
      "07:00" => 399,
      "08:00" => 503,
      "09:00" => 566,
      "10:00" => 595,
      "11:00" => 599,
      "12:00" => 547,
      "13:00" => 471,
      "14:00" => 374,
      "15:00" => 272,
      "16:00" => 152,
      "17:00" => 50,
      "18:00" => 16,
    },
    "july" => {
      "03:00" => 11,
      "04:00" => 48,
      "05:00" => 135,
      "06:00" => 279,
      "07:00" => 399,
      "08:00" => 503,
      "09:00" => 566,
      "10:00" => 595,
      "11:00" => 599,
      "12:00" => 547,
      "13:00" => 471,
      "14:00" => 374,
      "15:00" => 272,
      "16:00" => 152,
      "17:00" => 50,
      "18:00" => 16,
    },
    "august" => {
      "04:00" => 36,
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
      "18:00" => 16,
    },
    "september" => {
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
    "october" => {
      "06:00" => 8,
      "07:00" => 100,
      "08:00" => 175,
      "09:00" => 245,
      "10:00" => 287,
      "11:00" => 299,
      "12:00" => 274,
      "13:00" => 223,
      "14:00" => 139,
      "15:00" => 68,
      "16:00" => 1,
    },
    "november" => {
      "07:00" => 19,
      "08:00" => 108,
      "09:00" => 142,
      "10:00" => 193,
      "11:00" => 185,
      "12:00" => 162,
      "13:00" => 124,
      "14:00" => 72,
      "15:00" => 3,
    },
    "december" => {
      "07:00" => 19,
      "08:00" => 108,
      "09:00" => 142,
      "10:00" => 193,
      "11:00" => 185,
      "12:00" => 162,
      "13:00" => 124,
      "14:00" => 72,
      "15:00" => 3,
    },
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
