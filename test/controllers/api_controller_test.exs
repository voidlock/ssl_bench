defmodule SslBench.ApiControllerTest do
  use SslBench.ConnCase

  test "POST /api/endpoints" do
    conn = post conn(), "/api/endpoints"
    assert json_response(conn, 201)
  end
end
