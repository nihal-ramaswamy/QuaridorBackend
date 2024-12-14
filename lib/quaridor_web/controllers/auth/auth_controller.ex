defmodule QuaridorWeb.Auth.AuthController do
  @moduledoc """
  Handles sign up, sign in sign out.
  """
  alias Quaridor.Repo
  alias Quaridor.Account
  use QuaridorWeb, :controller

  def sign_in(conn, %{"email" => email, "unhashed_password" => _unhashed_password}) do
    # token = Quaridor.Jwt.JwtAuthToken.generate_and_sign!()
    json(conn, %{:email => email})
  end

  def sign_up(conn, %{"account" => account_params}) do
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
end
