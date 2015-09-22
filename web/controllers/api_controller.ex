defmodule SslBench.ApiController do
  use SslBench.Web, :controller

  def create(conn, _params) do
    conn
    |> put_status(:created)
    |> json %{ok: "good"}
  end
end
