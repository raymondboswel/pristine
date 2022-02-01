defmodule Ui.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ui.Data` context.
  """

  @doc """
  Generate a temp.
  """
  def temp_fixture(attrs \\ %{}) do
    {:ok, temp} =
      attrs
      |> Enum.into(%{
        value: 120.5
      })
      |> Ui.Data.create_temp()

    temp
  end
end
