class WeatherController < ApplicationController
  def index
    @city = params[:city]
    @country = params[:country]
    @weather_info = nil
    weather = OpenWeatherAPIService.new(Rails.application.secrets.openweatherapikey)
    if @city && @country
      cache("#{@city}_#{@country}_#{Date.today}".downcase){
        @weather_info = weather.weather_info_short(
                          weather.weather_info_raw(@country, @city)
                        )
      }
    elsif params[:randomize]
      @weather_info = weather.weather_info_short(
                        weather.weather_coords(rand(1..49), rand(1..130))
                      )
    end
  end
end
