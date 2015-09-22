defmodule SslBench.PageController do
  use SslBench.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
