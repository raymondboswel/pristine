defmodule Ui.Repo.Migrations.CreateDustValues do
  use Ecto.Migration

  def change do
    create table(:dust_values) do
      add :value, :float

      timestamps()
    end
  end
end
