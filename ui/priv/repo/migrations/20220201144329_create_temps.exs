defmodule Ui.Repo.Migrations.CreateTemps do
  use Ecto.Migration

  def change do
    create table(:temps) do
      add :value, :float

      timestamps()
    end
  end
end
