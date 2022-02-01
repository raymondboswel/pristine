defmodule UiWeb.TempLive.Show do
  use UiWeb, :live_view

  alias Ui.Data

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:temp, Data.get_temp!(id))}
  end

  defp page_title(:show), do: "Show Temp"
  defp page_title(:edit), do: "Edit Temp"
end
