defmodule SslBench.SinkSup do
  use Supervisor

  alias SslBench.Sink
  alias SslBench.TcpSinkListener

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    supervise([], strategy: :one_for_one)
  end

  def start_sink(sink=%Sink{mode: mode}) when mode == "tcp" do
    Supervisor.start_child(__MODULE__, ranch_worker(sink))
  end

  defp ranch_worker(sink) do
    worker(:ranch, ranch_args(sink), function: :start_listener, id: sink.id)
  end

  defp ranch_args(%Sink{ id: id, port: port}=sink) do
    [id, 2, :ranch_tcp, [port: port], TcpSinkListener, [sink]]
  end
end
