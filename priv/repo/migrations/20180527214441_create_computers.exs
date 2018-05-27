defmodule NotifyMe.Repo.Migrations.CreateComputers do
  use Ecto.Migration

  def change do
    create table(:computers) do
      add :name, :string
      add :uuid, :string
      add :last, :string

      timestamps()
    end

  end
end
