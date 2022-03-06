defmodule Firmware.GroveDust do
  require Logger
  def measure_level do
    Logger.debug("Measure dust level")
    pin = 8
    GrovePi.Digital.set_pin_mode(pin, :input)
    result = GrovePi.Digital.read(pin)
    Logger.debug("Result: #{result}")
    result
  end
end
