defmodule QuaridorWeb.Router do
  use QuaridorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuaridorWeb do
    pipe_through :api

    get "/health-check", HealthCheck, :health_check
  end
end
