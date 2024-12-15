defmodule Quaridor.Jwt.JwtAuthPlug do
  import Plug.Conn
  alias Quaridor.Jwt.JwtAuthToken

  def init(opts), do: opts

  def call(conn, _opts) do
    token =
      conn
      |> Plug.Conn.get_req_header("authorization")
      |> List.first()
      |> String.replace_prefix("Bearer ", "")

    jwt_data = token |> JwtAuthToken.verify_and_validate()

    case jwt_data do
      {:ok, claims} ->
        conn
        |> assign(:claims, claims)
        |> assign(:jwt_token, token)

      {:error, _error} ->
        conn
        |> resp(:unauthorized, "not logged in")
        |> send_resp()
        |> halt
    end
  end
end
