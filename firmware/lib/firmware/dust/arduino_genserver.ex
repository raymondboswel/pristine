defmodule Firmware.Dust.Arduino do
  use GenServer
  require Logger
  alias Circuits.UART

  @hex_name "arduino.hex"
  @board :uno
  @port "ttyACM0"
  @speed 9600


  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    send(self(), :setup)
    {:ok, %{port: nil}}
  end

  def handle_info(:setup, state) do
    {:ok, port} = UART.start_link()
    port_opts = [
      speed: @speed,
      framing: Circuits.UART.Framing.FourByte
    ]
    :ok = UART.open(port, @port, port_opts)
    UART.configure(port, framing: {Circuits.UART.Framing.Line, separator: "\r\n"})
    state = %{state | port: port}
    Process.send_after(self(), :read, 500)
    {:noreply, state}
  end

  def handle_info(:read, state) do
    UART.write(state.port, <<?A, 0>>)
    Process.send_after(self(), :read, 500)
    {:noreply, state}
  end

  def handle_info({:circuits_uart, _, msg}, state) do
    Logger.info("Message from arduino: #{inspect msg}")
    Ui.Data.create_dust_value(%{value: msg})
    {:noreply, state}
  end

end
