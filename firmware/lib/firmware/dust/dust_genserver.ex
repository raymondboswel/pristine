defmodule Firmware.DustGenserver do
  use GenServer
  require Logger

  # Client

  def start_link(_name \\ nil) do
    GenServer.start_link(__MODULE__, %{measurements: [], dust_value: nil, start_date: nil})
  end

  def dust_value(pid) do
    GenServer.call(pid, :dust_value)
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    Logger.debug("Initializing dust genserver")
    schedule_work()
    current_date = DateTime.utc_now()

    {:ok, Map.put(state, :start_date, current_date)}
  end

  @impl true
  def handle_call(:dust_value, _from, state) do
    {:reply, state.dust_value, state}
  end

  defp schedule_work() do
    Logger.debug("Schedule dust measurement...")

    Process.send_after(
      self(),
      :measure,
      10
    )
  end

  @impl true
  def handle_info(:measure, state) do
    # Do the desired work here
    # Reschedule once more

    now = DateTime.utc_now()
    sensor_level = Firmware.GroveDust.measure()
    Logger.debug(sensor_level)

    if(DateTime.diff(now, state.start_date) >= 30) do
      low_pulse_occupancy_ratio =
        state.measurements
        |> Enum.count(fn v -> v == 0 end)
        |> Kernel.div(length(state.measurements))

      {:noreply, %{state | measurements: [], dust_value: low_pulse_occupancy_ratio * 100}}
    else
      schedule_work()
      measurements = [sensor_level | state.measurements]
      {:noreply, %{state | measurements: measurements}}
    end
  end
end
