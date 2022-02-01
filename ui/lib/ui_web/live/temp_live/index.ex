defmodule UiWeb.TempLive.Index do
  use UiWeb, :live_view

  alias Ui.Data
  alias Ui.Data.Temp

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :temps, list_temps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Temp")
    |> assign(:temp, Data.get_temp!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Temp")
    |> assign(:temp, %Temp{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Temps")
    |> assign(:temp, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    temp = Data.get_temp!(id)
    {:ok, _} = Data.delete_temp(temp)

    {:noreply, assign(socket, :temps, list_temps())}
  end

  defp list_temps do
    Data.list_temps()
  end
end
