defmodule SslBench.SinkTest do
  use SslBench.ModelCase

  alias SslBench.Sink

  @valid_attrs %{mode: "tcp"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sink.changeset(%Sink{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sink.changeset(%Sink{}, @invalid_attrs)
    refute changeset.valid?
  end
end
