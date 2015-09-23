defmodule SslBench.NextSocket do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def next() do
    GenServer.call(__MODULE__, {:next})
  end

  def init(:ok) do
    :random.seed(:erlang.monotonic_time())
    table = :ets.new(:socket_registry, [:set, :protected])
    {:ok, table}
  end

  def handle_call({:next}, from, table) do
    port = :random.uniform(35_000) + 20_000
    case :ets.member(table, {:port, port}) do
      true ->
        handle_call({:next}, from, table)
      false ->
        :ets.insert(table, {:port, port})
    end
    {:reply, {:ok, port}, table}
  end
end
