defmodule QuaridorWeb.Router do
  use QuaridorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/health-check", QuaridorWeb.HealthCheck do
    pipe_through :api

    get "/", HealthCheckController, :health_check
  end

  scope "/auth", QuaridorWeb.Auth do
    pipe_through :api

    post "/sign-in", AuthController, :sign_in
    post "/sign-up", AuthController, :sign_up
  end
end
