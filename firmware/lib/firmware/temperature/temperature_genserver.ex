defmodule Firmware.TemperatureGenserver do
  use GenServer

  # Client

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def latest_value(pid) do
    GenServer.call(pid, :latest_value)
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:latest_value, _from, list) do
    {:reply, List.first(list), list}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    if length(state) > 6 do
      total = Enum.reduce(state, 0, fn el, acc -> acc + el.value end)
      avg = total / length(state)

      Ui.Data.create_temp(%{value: avg})

      {:noreply, [element]}
    else
      {:noreply, [element | state]}
    end
  end
end
