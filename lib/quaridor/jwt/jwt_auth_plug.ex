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

    jwt_data = token |> JwtAuthToken.verify_and_validate()
    {:ok, data} = jwt_data
    {:ok, email} = Map.fetch(data, "email")

    case jwt_data do
      {:ok, claims} ->
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

      {:error, _error} ->
        conn
        |> resp(:unauthorized, "not logged in")
        |> send_resp()
        |> halt
    end
  end
end
