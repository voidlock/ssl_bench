defmodule SslBench.SinkControllerTest do
  use SslBench.ConnCase

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "POST /api/endpoints", %{conn: conn} do
    conn = post conn, sink_path(conn, :create), sink: %{mode: "raw"}
    assert json_response(conn, 201)
  end
end
