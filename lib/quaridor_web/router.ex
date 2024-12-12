defmodule QuaridorWeb.Router do
  use QuaridorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuaridorWeb do
    pipe_through :api

    get "/health-check", HealthCheck, :health_check
  end

  scope "/auth", QuaridorWeb.Auth do
    pipe_through :api

    post "/sign-in", AuthController, :sign_in
  end
end
