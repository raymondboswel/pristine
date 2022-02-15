defmodule Firmware.DustGenserver do
  use GenServer
  require Logger

  # Client

  def start_link(_name \\ nil) do
    GenServer.start_link(__MODULE__, [])
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    Logger.debug("Initializing dust genserver")
    schedule_work()
    {:ok, stack}
  end

  defp schedule_work() do
    Logger.debug("Schedule dust measurement...")

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

    dust = Firmware.GroveDust.measure()
    Logger.debug(dust)

    schedule_work()
    {:noreply, state}
  end
end
