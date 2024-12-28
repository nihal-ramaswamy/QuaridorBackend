defmodule QuaridorWeb.RoomChannel do
  use QuaridorWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("create", payload, socket) do
    code = Quaridor.Game.GameUtils.generate_unique_code()
    IO.inspect(payload)
    {:reply, {:ok, code}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
