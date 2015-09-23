defmodule SslBench.SinkController do
  use SslBench.Web, :controller
  alias SslBench.Sink

  plug :scrub_params, "sink" when action in [:create]

  def create(conn, %{"sink" => params}) do
    changeset = Sink.changeset(%Sink{}, params)

    case Repo.insert(changeset) do
      {:ok, sink} ->
        conn
        |> put_status(:created)
        |> json sink
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SslBench.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
