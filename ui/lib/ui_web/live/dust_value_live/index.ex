defmodule UiWeb.DustValueLive.Index do
  use UiWeb, :live_view

  alias Ui.Data
  alias Ui.Data.DustValue

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :dust_values, list_dust_values())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Dust value")
    |> assign(:dust_value, Data.get_dust_value!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Dust value")
    |> assign(:dust_value, %DustValue{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Dust values")
    |> assign(:dust_value, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    dust_value = Data.get_dust_value!(id)
    {:ok, _} = Data.delete_dust_value(dust_value)

    {:noreply, assign(socket, :dust_values, list_dust_values())}
  end

  defp list_dust_values do
    Data.list_dust_values()
  end
end
