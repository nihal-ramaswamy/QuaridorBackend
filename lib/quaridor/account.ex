defmodule Quaridor.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  Account details to store in the database. Make sure the password is hashed before storing.
  """
  @type t :: %Quaridor.Account{
          password: String.t(),
          in_game_name: String.t(),
          email: String.t(),
          is_admin: boolean()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :password, :string
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

  @doc """
  Returns the hashed password
  """
  @spec hash_password(String.t()) :: String.t()
  def hash_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end

  def is_password_match?(password, unhashed_password) do
    Bcrypt.verify_pass(unhashed_password, password)
  end
end
