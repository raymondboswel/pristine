defmodule Firmware.Scheduler do
  use GenServer
  alias Firmware.TempValue
  alias Firmware.TemperatureGenserver
  alias Firmware.GroveTemperature
  require Logger

  # Client

  def start_link(_name \\ nil) do
    GenServer.start_link(__MODULE__, [])
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    Logger.debug("Initializing scheduler")
    schedule_work()
    {:ok, stack}
  end

  defp schedule_work() do
    Logger.debug("Schedule work...")

    Process.send_after(
      self(),
      :measure,
      2000
    )
  end

  @impl true
  def handle_info(:measure, state) do
    # Do the desired work here
    # Reschedule once more

    now = Timex.now("Africa/Johannesburg") |> DateTime.to_naive()

    Logger.debug("Now #{now}")

    _fake_temp = read_temp_fake()
    temp = GroveTemperature.measure()
    Logger.debug(inspect(temp))

    tempPid = Process.whereis(Firmware.TemperatureGenserver)
    TemperatureGenserver.push(tempPid, temp)

    sgp30 = Sgp30.state()

    Ui.Data.create_voc(%{
      eco2: sgp30,
      ethanol_raw: sgp30.ethanol_raw,
      h2_raw: sgp30.h2_raw,
      tvoc: sgp30.tvoc
    })

    schedule_work()
    {:noreply, state}
  end

  defp read_temp_fake() do
    value = :rand.uniform(30)
    date = Timex.now("Africa/Johannesburg") |> DateTime.to_naive()
    %TempValue{date: date, value: value}
  end

  # defp read_temp() do
  #   File.ls!(@base_dir)
  #   |> Enum.filter(&String.starts_with?(&1, "28-"))
  #   |> Enum.each(&read_temp_file(&1, @base_dir))
  # end

  # defp read_temp_file(sensor, base_dir) do
  #   sensor_data = File.read!("#{base_dir}#{sensor}/w1_slave")
  #   Logger.debug("reading sensor: #{sensor}: #{sensor_data}")

  #   {temp, _} =
  #     Regex.run(~r/t=(\d+)/, sensor_data)
  #     |> List.last()
  #     |> Float.parse()

  #   Logger.debug("#{temp / 1000} C")
  #   temp
  # end
end
