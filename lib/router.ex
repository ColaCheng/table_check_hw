defmodule TableCheckHw.Router do
  require Logger
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Telemetry, event_prefix: [:table_check_hw, :http])

  plug(Plug.Logger, log: :debug)

  plug(Plug.Parsers,
    parsers: [json: [json_decoder: Jason]],
    pass: ["application/json"]
  )

  plug(:match)
  plug(:dispatch)

  get "/health" do
    send_resp(conn, 204, "")
  end

  get "/metrics" do
    metrics = TableCheckHw.Telemetry.scrape()
    send_resp(conn, 200, metrics)
  end

  forward("/", to: TableCheckHw.Routes.Public)

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = err) do
    Logger.error(err)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
