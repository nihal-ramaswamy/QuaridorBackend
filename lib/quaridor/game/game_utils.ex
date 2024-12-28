defmodule Quaridor.Game.GameUtils do
  alias Quaridor.Game.GameMemento
  @characters ~c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

  def generate_unique_code() do
    code = random_string(10)

    case GameMemento.is_code_in_use?(code) do
      true -> generate_unique_code()
      false -> code
    end
  end

  defp random_string(len) do
    1..len
    |> Enum.reduce([], fn _, acc -> [Enum.random(@characters) | acc] end)
    |> IO.iodata_to_binary()
  end
end
