defmodule Quaridor.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :in_game_name, :string, null: false
      add :email, :string
      add :password, :string, null: false
      add :is_admin, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:accounts, [:email])
    create unique_index(:accounts, [:in_game_name])
  end
end
