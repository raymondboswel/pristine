defmodule Ui.Data do
  @moduledoc """
  The Data context.
  """

  import Ecto.Query, warn: false
  alias Ui.Repo

  alias Ui.Data.Temp

  @doc """
  Returns the list of temps.

  ## Examples

      iex> list_temps()
      [%Temp{}, ...]

  """
  def list_temps do
    Repo.all(Temp)
  end

  @doc """
  Gets a single temp.

  Raises `Ecto.NoResultsError` if the Temp does not exist.

  ## Examples

      iex> get_temp!(123)
      %Temp{}

      iex> get_temp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_temp!(id), do: Repo.get!(Temp, id)

  @doc """
  Creates a temp.

  ## Examples

      iex> create_temp(%{field: value})
      {:ok, %Temp{}}

      iex> create_temp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_temp(attrs \\ %{}) do
    %Temp{}
    |> Temp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a temp.

  ## Examples

      iex> update_temp(temp, %{field: new_value})
      {:ok, %Temp{}}

      iex> update_temp(temp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_temp(%Temp{} = temp, attrs) do
    temp
    |> Temp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a temp.

  ## Examples

      iex> delete_temp(temp)
      {:ok, %Temp{}}

      iex> delete_temp(temp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_temp(%Temp{} = temp) do
    Repo.delete(temp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking temp changes.

  ## Examples

      iex> change_temp(temp)
      %Ecto.Changeset{data: %Temp{}}

  """
  def change_temp(%Temp{} = temp, attrs \\ %{}) do
    Temp.changeset(temp, attrs)
  end

  alias Ui.Data.DustValue

  @doc """
  Returns the list of dust_values.

  ## Examples

      iex> list_dust_values()
      [%DustValue{}, ...]

  """
  def list_dust_values do
    Repo.all(DustValue)
  end

  @doc """
  Gets a single dust_value.

  Raises `Ecto.NoResultsError` if the Dust value does not exist.

  ## Examples

      iex> get_dust_value!(123)
      %DustValue{}

      iex> get_dust_value!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dust_value!(id), do: Repo.get!(DustValue, id)

  @doc """
  Creates a dust_value.

  ## Examples

      iex> create_dust_value(%{field: value})
      {:ok, %DustValue{}}

      iex> create_dust_value(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dust_value(attrs \\ %{}) do
    %DustValue{}
    |> DustValue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dust_value.

  ## Examples

      iex> update_dust_value(dust_value, %{field: new_value})
      {:ok, %DustValue{}}

      iex> update_dust_value(dust_value, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dust_value(%DustValue{} = dust_value, attrs) do
    dust_value
    |> DustValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dust_value.

  ## Examples

      iex> delete_dust_value(dust_value)
      {:ok, %DustValue{}}

      iex> delete_dust_value(dust_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dust_value(%DustValue{} = dust_value) do
    Repo.delete(dust_value)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dust_value changes.

  ## Examples

      iex> change_dust_value(dust_value)
      %Ecto.Changeset{data: %DustValue{}}

  """
  def change_dust_value(%DustValue{} = dust_value, attrs \\ %{}) do
    DustValue.changeset(dust_value, attrs)
  end
end
