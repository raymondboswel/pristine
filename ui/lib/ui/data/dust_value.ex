defmodule Ui.Data.DustValue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dust_values" do
    field :value, :float

    timestamps()
  end

  @doc false
  def changeset(dust_value, attrs) do
    dust_value
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
