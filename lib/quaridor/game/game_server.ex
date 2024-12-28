defmodule Quaridor.Game.GameServer do
  alias Quaridor.Dto.Game
  use GenServer, restart: :transient

  # 10 minutes
  @timeout 600_000

  def start_link(options) do
    new_game = Game.new_game(options.player1, options.player2, options.game_code)
    GenServer.start_link(__MODULE__, new_game, options)
  end

  @impl true
  def init(game) do
    {:ok, game, @timeout}
  end

  @impl true
  def handle_call(:game, _from, game) do
    {:noreply, game, game, @timeout}
  end

  @impl true
  def handle_cast({:move, position}, game) do
    {:noreply, Game.move(game, position), @timeout}
  end

  @impl true
  def handle_info(:timeout, game) do
    {:stop, :normal, game}
  end
end
