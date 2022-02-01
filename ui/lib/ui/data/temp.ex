defmodule Ui.Data.Temp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "temps" do
    field :value, :float

    timestamps()
  end

  @doc false
  def changeset(temp, attrs) do
    temp
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
