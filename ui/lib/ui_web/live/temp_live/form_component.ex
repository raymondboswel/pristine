defmodule UiWeb.TempLive.FormComponent do
  use UiWeb, :live_component

  alias Ui.Data

  @impl true
  def update(%{temp: temp} = assigns, socket) do
    changeset = Data.change_temp(temp)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"temp" => temp_params}, socket) do
    changeset =
      socket.assigns.temp
      |> Data.change_temp(temp_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"temp" => temp_params}, socket) do
    save_temp(socket, socket.assigns.action, temp_params)
  end

  defp save_temp(socket, :edit, temp_params) do
    case Data.update_temp(socket.assigns.temp, temp_params) do
      {:ok, _temp} ->
        {:noreply,
         socket
         |> put_flash(:info, "Temp updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_temp(socket, :new, temp_params) do
    case Data.create_temp(temp_params) do
      {:ok, _temp} ->
        {:noreply,
         socket
         |> put_flash(:info, "Temp created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
