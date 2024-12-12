defmodule Quaridor.Repo do
  use Ecto.Repo,
    otp_app: :quaridor,
    adapter: Ecto.Adapters.Postgres
end
