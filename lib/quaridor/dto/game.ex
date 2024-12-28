defmodule Quaridor.Dto.Game do
  alias Quaridor.Dto.Game
  @enforce_keys [:player1, :player2, :turn, :game_state, :game_code]
  @type t() :: %__MODULE__{
          player1: String.t() | nil,
          player2: String.t() | nil,
          turn: boolean(),
          game_state: String.t(),
          history: list(String.t()),
          game_code: String.t()
        }
  defstruct player1: nil, player2: nil, turn: true, game_state: "", history: [], game_code: ""

  @doc """
  Returns a map with default values set. Takes the two player's sockets to send data to.
  """
  @spec new_game(String.t(), String.t(), String.t()) :: Game.t()
  def new_game(player1, player2, game_code) do
    %Game{
      player1: player1,
      player2: player2,
      turn: true,
      game_state: Game.new_board(),
      history: [],
      game_code: game_code
    }
  end

  # TODO: Implement starting position
  @doc """
  Returns starting position of the game.
  """
  @spec new_board() :: String.t()
  def new_board() do
    ""
  end

  # TODO: Implement move function
  @doc """
  Updates the board by making the move. Updates the player turn and history as well.
  """
  @spec move(Game.t(), String.t()) :: Game.t()
  def move(game, _move) do
    game
  end
end
