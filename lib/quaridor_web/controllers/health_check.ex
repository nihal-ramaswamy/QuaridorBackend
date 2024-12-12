defmodule QuaridorWeb.HealthCheck do
  use QuaridorWeb, :controller

  def health_check(conn, _params) do
    json(conn, %{:message => "Hello World!"})
  end
end
