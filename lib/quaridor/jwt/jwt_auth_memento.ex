defmodule Quaridor.Jwt.JwtAuthMemento do
  use Memento.Table,
    attributes: [:email, :token]

  def is_email_logged_in?(email, token) do
    {:ok, data} =
      Memento.transaction(fn ->
        Memento.Query.read(Quaridor.Jwt.JwtAuthMemento, email)
      end)

    if nil == data do
      false
    end

    case IO.inspect(Map.fetch(data, :token)) do
      {:ok, db_token} -> token == db_token
      nil -> false
    end
  end

  @doc """
  Creates a new token record in the table. If data already exists for that email, it first deletes it.
  """
  def delete_and_write(email, token) do
    Memento.transaction(fn ->
      Memento.Query.delete(Quaridor.Jwt.JwtAuthMemento, email)
      Memento.Query.write(%Quaridor.Jwt.JwtAuthMemento{email: email, token: token})
    end)
  end

  @doc """
  Delete entry of token from database.
  """
  def delete_token(email) do
    Memento.transaction(fn ->
      Memento.Query.delete(Quaridor.Jwt.JwtAuthMemento, email)
    end)
  end
end
