defmodule Quaridor.Game.GameMemento do
  use Memento.Table, attributes: [:id, :code]

  @doc """
  Check if the current code is being used already.
  """
  @spec is_code_in_use?(String.t()) :: boolean()

  def is_code_in_use?(code) do
    guards = [
      {:==, :code, code}
    ]

    {:ok, data} =
      Memento.transaction(fn ->
        Memento.Query.select(Quaridor.Game.GameMemento, guards)
      end)

    case length(data) do
      0 -> false
      _ -> true
    end
  end

  def add_player_game(id, code) do
    Memento.transaction(fn ->
      Memento.Query.write(%Quaridor.Game.GameMemento{id: id, code: code})
    end)
  end

  def delete_player_game(id) do
    Memento.transaction(fn ->
      Memento.Query.delete(Quaridor.Game.GameMemento, id)
    end)
  end
end
