defmodule Quaridor.Jwt.JwtAuthToken do
  @salt "user auth"

  def set_claims(data) do
    {:ok, email} = Map.fetch(data, :email)
    {:ok, is_admin} = Map.fetch(data, :is_admin)
    {:ok, in_game_name} = Map.fetch(data, :in_game_name)

    %{
      :email => email,
      :is_admin => is_admin,
      :in_game_name => in_game_name
    }
  end

  def sign(data) do
    Phoenix.Token.sign(QuaridorWeb.Endpoint, @salt, data)
  end

  def get_claims(token) do
    Phoenix.Token.verify(QuaridorWeb.Endpoint, @salt, token, max_age: 86400)
  end
end
