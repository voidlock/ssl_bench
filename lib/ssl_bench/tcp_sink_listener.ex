defmodule SslBench.TcpSinkListener do
  require Logger

  def start_link(ref, socket, transport, opts) do
    pid = spawn_link(__MODULE__, :init, [ref, socket, transport, opts])
    {:ok, pid}
  end

  def init(ref, socket, transport, _opts \\ []) do
    :ok = :ranch.accept_ack(ref)
    loop(socket, transport)
  end

  defp loop(socket, transport) do
    case transport.recv(socket, 0, 5000) do
      {:ok, data} ->
        Logger.info "at=recv data=#{data}"
        loop(socket, transport)
        _ ->
          :ok = transport.close(socket)
    end
  end
end
