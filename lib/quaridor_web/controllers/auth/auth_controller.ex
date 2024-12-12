defmodule QuaridorWeb.Auth.AuthController do
  @moduledoc """
  Handles sign up, sign in sign out.
  """
  use QuaridorWeb, :controller

  def sign_in(conn, %{"email" => email, "unhashed_password" => unhashed_password}) do
    IO.inspect("Email: #{email}\nUnhashed Password: #{unhashed_password}")

    json(conn, %{:email => email})
  end
end
