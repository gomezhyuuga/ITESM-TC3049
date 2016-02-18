#!/usr/bin/env ruby -I . -w
# Observer Pattern
# Date: 03-Feb-2016
# Authors:
#          A01020319 Fernando Gómez Herrera
require 'minitest/autorun'
require 'stringio'
require 'weather'

class WeatherTest < Minitest::Test

  def setup
    @out = StringIO.new
    @old_stdout = $stdout
    $stdout = @out
    @weather_data = WeatherData.new
  end

  def teardown
    $stdout = @old_stdout
  end

  def do_set_measurements
    @weather_data.set_measurements(80.0, 65.0, 30.4)
    @weather_data.set_measurements(82.0, 70.0, 29.2)
    @weather_data.set_measurements(78.0, 90.0, 29.2)
  end

  def test_current_conditions_display
    current_display = CurrentConditionsDisplay.new
    @weather_data.add_observer(current_display)
    do_set_measurements
    assert_equal "Current conditions: 80.0°F and 65.0% humidity\n"  \
                 "Current conditions: 82.0°F and 70.0% humidity\n"  \
                 "Current conditions: 78.0°F and 90.0% humidity\n", \
                 @out.string
  end

  def test_statistics_display
    statistics_display = StatisticsDisplay.new
    @weather_data.add_observer(statistics_display)
    do_set_measurements
    assert_equal "Avg/Max/Min temperature = 80.0/80.0/80.0\n"  \
                 "Avg/Max/Min temperature = 81.0/82.0/80.0\n"  \
                 "Avg/Max/Min temperature = 80.0/82.0/78.0\n", \
                 @out.string
  end

  def test_forecast_display
    forecast_display = ForecastDisplay.new
    @weather_data.add_observer(forecast_display)
    do_set_measurements
    assert_equal "Forecast: Improving weather on the way!\n"       \
                 "Forecast: Watch out for cooler, rainy weather\n" \
                 "Forecast: More of the same\n",                   \
                 @out.string
  end

  def test_all_together
    current_display = CurrentConditionsDisplay.new
    statistics_display = StatisticsDisplay.new
    forecast_display = ForecastDisplay.new
    @weather_data.add_observer(current_display)
    @weather_data.add_observer(statistics_display)
    @weather_data.add_observer(forecast_display)
    do_set_measurements
    assert_equal "Current conditions: 80.0°F and 65.0% humidity\n" \
                 "Avg/Max/Min temperature = 80.0/80.0/80.0\n"      \
                 "Forecast: Improving weather on the way!\n"       \
                 "Current conditions: 82.0°F and 70.0% humidity\n" \
                 "Avg/Max/Min temperature = 81.0/82.0/80.0\n"      \
                 "Forecast: Watch out for cooler, rainy weather\n" \
                 "Current conditions: 78.0°F and 90.0% humidity\n" \
                 "Avg/Max/Min temperature = 80.0/82.0/78.0\n"      \
                 "Forecast: More of the same\n",                   \
                 @out.string
  end

end
