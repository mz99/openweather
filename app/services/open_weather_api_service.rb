require 'HTTParty'
require 'json'
require 'uri'

class OpenWeatherAPIService
  BASE_URL='http://api.openweathermap.org/data/2.5'.freeze

  def initialize(key)
    @key = key || 'd0335d03d435354f94b407571381acb6'
  end

  def weather_info(country_code, city)
    response = HTTParty.get(URI.encode("#{BASE_URL}/weather?q=#{city},#{country_code}&APPID=#{@key}"))
    JSON.parse(response.body)
  end

end
