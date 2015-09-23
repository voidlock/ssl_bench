defmodule SslBench.Sink do
  use SslBench.Web, :model
  alias SslBench.NextSocket

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "sinks" do
    field :mode, :string
    field :port, :integer

    timestamps
  end

  @required_fields ~w(mode)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> maybe_generate_port
    |> validate_inclusion :mode, ["https", "tcp"], message: ~s|must be one of: tcp, https|
  end

  defp maybe_generate_port(changeset) do
    case get_change(changeset, :mode) do
      "tcp" ->
        {:ok, port} = NextSocket.next()
        put_change(changeset, :port, port)
        _ -> changeset
    end
  end
end
