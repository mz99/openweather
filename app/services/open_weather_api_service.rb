require 'HTTParty'
require 'json'
require 'uri'

class OpenWeatherAPIService
  BASE_URL='http://api.openweathermap.org/data/2.5'.freeze

  def initialize(key)
    @key = key
  end

  def weather_info_raw(country_code, city,unit='metric')
    response = HTTParty.get(URI.encode("#{BASE_URL}/weather?q=#{city},#{country_code}&units=#{unit}&APPID=#{@key}"))
    JSON.parse(response.body)
  end

  def weather_coords(lat=35,lon=139, unit="metric")
    response = HTTParty.get(URI.encode("#{BASE_URL}/weather?lat=#{lat}&lon=#{lon}&units=#{unit}&APPID=#{@key}"))
    JSON.parse(response.body)
  end

  def weather_info_short(wi)
    {
      "city_name" => wi["name"],
      "current_temp" => wi.dig("main", "temp"),
      "humidity" => "#{wi.dig("main", "humidity")}%",
      "description" => wi.dig("weather", 0, "description"),
      "lon" => wi.dig("coord", "lon"),
      "lat" => wi.dig("coord", "lat")
    }
  end

end
