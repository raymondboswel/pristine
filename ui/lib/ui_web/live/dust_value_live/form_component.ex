defmodule UiWeb.DustValueLive.FormComponent do
  use UiWeb, :live_component

  alias Ui.Data

  @impl true
  def update(%{dust_value: dust_value} = assigns, socket) do
    changeset = Data.change_dust_value(dust_value)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"dust_value" => dust_value_params}, socket) do
    changeset =
      socket.assigns.dust_value
      |> Data.change_dust_value(dust_value_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"dust_value" => dust_value_params}, socket) do
    save_dust_value(socket, socket.assigns.action, dust_value_params)
  end

  defp save_dust_value(socket, :edit, dust_value_params) do
    case Data.update_dust_value(socket.assigns.dust_value, dust_value_params) do
      {:ok, _dust_value} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dust value updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_dust_value(socket, :new, dust_value_params) do
    case Data.create_dust_value(dust_value_params) do
      {:ok, _dust_value} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dust value created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
