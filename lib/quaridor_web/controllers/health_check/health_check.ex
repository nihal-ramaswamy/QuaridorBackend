defmodule QuaridorWeb.HealthCheck.HealthCheckController do
  use QuaridorWeb, :controller

  def health_check(conn, _params) do
    json(conn, %{:message => "Hello World!"})
  end
end
