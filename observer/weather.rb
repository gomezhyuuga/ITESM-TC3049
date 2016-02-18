#!/usr/bin/env ruby -I . -w
# Observer Pattern
# Date: 03-Feb-2016
# Authors:
#          A01020319 Fernando Gómez Herrera
require "observer"
class WeatherData
  include Observable

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure

    changed
    notify_observers(@temperature, @humidity, @pressure)
  end
end

class CurrentConditionsDisplay
  def update(temperature, humidity, pressure)
    puts "Current conditions: #{temperature}°F and #{humidity}% humidity"
  end
end
class StatisticsDisplay
  def initialize
    @max_temp = 0.0
    @min_temp = 0.0
    @temps = []
    @counter = 0
  end
  def calc_avg_temp
    (@temps.reduce :+ ) * 1.0 / @temps.length
  end
  def update(temperature, humidity, pressure)
    @temps << temperature
    @max_temp = temperature if temperature > @max_temp
    @min_temp = temperature if temperature < @min_temp || @min_temp == 0.0

    puts "Avg/Max/Min temperature = #{calc_avg_temp}/#{@max_temp}/#{@min_temp}"
  end
end

class ForecastDisplay
  def initialize
    @last_pressure = 0.0
  end

  def update(temperature, humidity, pressure)
    if pressure > @last_pressure # Predicts an improvement on the weather
      puts "Forecast: Improving weather on the way!"
    elsif pressure < @last_pressure # Predicts a cooler, rainy weather.
      puts "Forecast: Watch out for cooler, rainy weather"
    else # Will stay the same
      puts "Forecast: More of the same"
    end

    @last_pressure = pressure
  end
end
