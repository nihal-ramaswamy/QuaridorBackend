defmodule QuaridorWeb.GameSocket do
  alias Quaridor.Jwt.JwtAuthToken
  alias Quaridor.Account
  alias Quaridor.Repo
  use Phoenix.Socket

  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels
  # Uncomment the following line to define a "room:*" topic
  # pointing to the `QuaridorWeb.RoomChannel`:
  #
  channel "room:*", QuaridorWeb.RoomChannel
  #
  # To create a channel file, use the mix task:
  #
  #     mix phx.gen.channel Room
  #
  # See the [`Channels guide`](https://hexdocs.pm/phoenix/channels.html)
  # for further details.

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error` or `{:error, term}`. To control the
  # response the client receives in that case, [define an error handler in the
  # websocket
  # configuration](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#socket/3-websocket-configuration).
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"token" => token}, socket, _connect_info) do
    jwt_data = token |> JwtAuthToken.get_claims()

    case jwt_data do
      {:error, _} ->
        {:error, :unauthorized}

      {:ok, claims} ->
        {:ok, email} = Map.fetch(claims, :email)
        data = Repo.get_by(Account, email: email)

        if nil == data do
          {:error, :unauthorized}
        end

        case Map.fetch(data, :id) do
          :error ->
            {:error, :unauthorized}

          {:ok, id} ->
            socket = assign(socket, :user_id, id)
            {:ok, socket}
        end
    end
  end

  # Socket IDs are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Elixir.QuaridorWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
