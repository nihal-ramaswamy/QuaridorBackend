defmodule Quaridor.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :password, :string, redact: true
    field :unhashed_password, :string, virtual: true
    field :in_game_name, :string
    field :email, :string
    field :is_admin, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:in_game_name, :email, :password, :is_admin])
    |> validate_format(:email, ~r/^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$/, message: "invalid email")
    |> validate_required([:in_game_name, :email, :password, :is_admin])
    |> unique_constraint(:email)
    |> unique_constraint(:in_game_name)
  end
end
