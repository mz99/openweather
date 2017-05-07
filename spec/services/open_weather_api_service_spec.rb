require 'spec_helper'
require 'HTTParty'
require 'json'
require 'uri'
require File.join(File.dirname(__FILE__), '..', '..', 'app', 'services','open_weather_api_service.rb')
require 'fakeweb'

RSpec.describe OpenWeatherAPIService do
  describe 'fetches' do
    FakeWeb.register_uri(
      :get,
      "http://api.openweathermap.org/data/2.5/weather?q=Berlin,DE&units=metric&APPID=xxx",
      body: '{ "temperature":30 }'
    )
    it 'fetches the api' do
      weather = OpenWeatherAPIService.new('xxx')
      response = weather.weather_info_raw('DE', 'Berlin',unit='metric')
      expect(response).to be_an_instance_of(Hash)
      expect(response['temperature']).to eq(30)
    end
  end
end
