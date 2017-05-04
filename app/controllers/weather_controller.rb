class WeatherController < ApplicationController
  def index
    @city = params[:city]
    @country = params[:country]
    @weather_info = nil
    if @city && @country
      cache("#{@city}_#{@country}_#{Date.today}".downcase){
        weather = OpenWeatherAPIService.new(Rails.application.secrets.openweatherapikey)
        @weather_info = weather.weather_info(@country, @city)
      }
    end
  end


end
