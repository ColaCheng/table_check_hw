defmodule TableCheckHw.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    http_port = Application.get_env(:table_check_hw, :http_port, 8080)

    children = [
      TableCheckHw.Repo,
      {Plug.Cowboy, scheme: :http, plug: TableCheckHw.Router, options: cowboy_opts(http_port)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TableCheckHw.Supervisor]

    Logger.info("Starting application. Listening on port #{http_port}")

    Supervisor.start_link(children, opts)
  end

  defp cowboy_opts(http_port) do
    [
      port: http_port,
      transport_options: [
        # default: 16_384, This is for limiting concurrent accept connections.
        max_connections: :infinity,
        # default: 100
        num_acceptors: 100
      ]
    ]
  end
end
