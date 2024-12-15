defmodule Quaridor.Jwt.JwtAuthToken do
  use Joken.Config

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
end
