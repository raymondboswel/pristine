defmodule Firmware.GroveTemperature do
  alias Firmware.TempValue

  def measure do
    pin = 14
    date = Timex.now("Africa/Johannesburg") |> DateTime.to_naive()

    raw = GrovePi.Analog.read(pin)
    r0 = 100_000
    b = 4275
    r = r0 * (1023.0 / raw - 1)
    temp = 1.0 / (:math.log(r / r0) / b + 1 / 298.15) - 273.15
    %TempValue{date: date, value: temp}
  end
end
