defmodule Quaridor.Jwt.JwtAuthPlug do
  import Plug.Conn
  alias Quaridor.Jwt.JwtAuthMemento
  alias Quaridor.Jwt.JwtAuthToken

  def init(opts), do: opts

  def call(conn, _opts) do
    token =
      conn
      |> Plug.Conn.get_req_header("authorization")
      |> List.first()
      |> String.replace_prefix("Bearer ", "")

    jwt_data = token |> JwtAuthToken.get_claims()

    case jwt_data do
      {:error, _data} ->
        conn
        |> resp(:unauthorized, "not logged in")
        |> send_resp()
        |> halt

      {:ok, claims} ->
        {:ok, email} = Map.fetch(claims, :email)

        case JwtAuthMemento.is_email_logged_in?(email, token) do
          true ->
            conn
            |> assign(:claims, claims)
            |> assign(:jwt_token, token)

          false ->
            conn
            |> resp(:unauthorized, "not logged in")
            |> send_resp()
            |> halt
        end
    end
  end
end
