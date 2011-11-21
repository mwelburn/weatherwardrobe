class HomeController < ApplicationController
  require 'open-uri'
  require 'json'

  WUNDERGROUND_API_KEY = '241c0e4c6a9d746e'

  def index

  end

  def weather_via_ajax
    latitude = params[:latitude]
    longitude = params[:longitude]
    zipcode = params[:zipcode]
    ip_address = request.remote_ip

    if !zipcode.nil?
      # TODO - check database to see if we already have a recent object in there

      query_params = zipcode + '.json'
    elsif !latitude.nil? and !longitude.nil?
      query_params = latitude + ',' + longitude + '.json'
    elsif !ip_address.nil?
      query_params = 'autoip.json?geo_ip=' + ip_address
    else
      # TODO - handle Invalid request parameters. This shouldn't ever happen...
    end
    
    open('http://api.wunderground.com/api/' + WUNDERGROUND_API_KEY + '/geolookup/conditions/forecast/q/' + query_params) do |f|
      json_string = f.read
      parsed_json = JSON.parse(json_string)
      location = parsed_json['location']['city']
      #print parsed_json
      forecast_temp_f = parsed_json['forecast']['simpleforecast']['forecastday'][0]['high']["fahrenheit"]
      #print parsed_json['forecast']['simpleforecast']['forecastday'][0]['high']["fahrenheit"]
      temp_f = parsed_json['current_observation']['temp_f']
      print "Current temperature in #{location} is: #{temp_f}\n"
      print "Forecasted temperature in #{location} is: #{forecast_temp_f}\n"

      # TODO - create a location object(?) if it doesn't exist

      # TODO - create a weather object

    end

  end

end
