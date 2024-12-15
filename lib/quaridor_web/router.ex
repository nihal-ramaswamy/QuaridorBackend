defmodule QuaridorWeb.Router do
  alias Quaridor.Jwt.JwtAuthPlug
  use QuaridorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_auth do
    plug :accepts, ["json"]
    plug JwtAuthPlug
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

  scope "/test", QuaridorWeb.HealthCheck do
    pipe_through :jwt_auth

    get "/", HealthCheckController, :health_check
  end
end
