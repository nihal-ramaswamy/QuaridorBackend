defmodule QuaridorWeb.Auth.AuthController do
  @moduledoc """
  Handles sign up, sign in sign out.
  """
  alias Quaridor.Jwt.JwtAuthToken
  alias Quaridor.Repo
  alias Quaridor.Account
  use QuaridorWeb, :controller

  @doc """
  Handles sign in. Returns a token for authentication
  """
  @spec sign_in(Plug.Conn.t(), %{email: String.t(), password: String.t()}) ::
          Plug.Conn.t()
  def sign_in(conn, %{"email" => email, "password" => unhashed_password}) do
    data = Repo.get_by(Account, email: email)

    if nil == data do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Invalid credentials"})
    end

    case Map.fetch(data, :password) do
      :error ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Error fetching data"})

      {:ok, password} ->
        case Account.is_password_match?(password, unhashed_password) do
          true ->
            handle_sign_in(conn, data)

          false ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Invalid credentials"})
        end
    end
  end

  @doc """
  Handle creation of new account. Hashes the password before storing it into the DB.
  """
  @spec sign_up(Plug.Conn.t(), Account.t()) :: Plug.Conn.t()
  def(sign_up(conn, %{"account" => account_params})) do
    case Map.fetch(account_params, "password") do
      {:ok, unhashed_password} ->
        handle_sign_up(conn, account_params, unhashed_password)

      :error ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Error registering account"})
    end
  end

  defp handle_sign_up(conn, account_params, unhashed_password) do
    # TODO: hash password once converted to account type
    account_params = %{
      account_params
      | "password" => Account.hash_password(unhashed_password)
    }

    changeset = Account.changeset(%Account{}, account_params)

    case Repo.insert(changeset) do
      {:ok, _account} ->
        conn |> put_status(:ok) |> json(%{message: "Account registered successfully"})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Error registering account"})
    end
  end

  defp handle_sign_in(conn, data) do
    extra_claim = JwtAuthToken.set_claims(data)
    token = JwtAuthToken.generate_and_sign!(extra_claim)

    conn
    |> put_status(:ok)
    |> json(%{:token => token})
  end
end
