defmodule Firmware.GroveDust do
  def measure_level do
    pin = 8
    GrovePi.Digital.set_pin_mode(pin, :input)
    GrovePi.Digital.read(pin)
  end
end
