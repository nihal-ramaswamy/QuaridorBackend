defmodule Quaridor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Memento.Table.create!(Quaridor.Jwt.JwtAuthMemento)
    Memento.Table.create!(Quaridor.Game.GameMemento)

    children = [
      QuaridorWeb.Telemetry,
      Quaridor.Repo,
      {DNSCluster, query: Application.get_env(:quaridor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Quaridor.PubSub},
      # Start a worker by calling: Quaridor.Worker.start_link(arg)
      # {Quaridor.Worker, arg},
      # Start to serve requests, typically the last entry
      QuaridorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Quaridor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuaridorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
