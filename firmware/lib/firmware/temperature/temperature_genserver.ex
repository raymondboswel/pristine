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
    # TODO: if list size greater that e.g 3600, dump to file and add element to new empty list

    {:noreply, [element | state]}
  end

end
