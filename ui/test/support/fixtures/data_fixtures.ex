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

  @doc """
  Generate a dust_value.
  """
  def dust_value_fixture(attrs \\ %{}) do
    {:ok, dust_value} =
      attrs
      |> Enum.into(%{
        value: 120.5
      })
      |> Ui.Data.create_dust_value()

    dust_value
  end
end
