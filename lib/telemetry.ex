defmodule TableCheckHw.Telemetry do
  @moduledoc """
  Entrypoint for TableCheckHw metrics. More related modules may be found in lib/telemetry/
  """
  use Supervisor
  import Telemetry.Metrics
  require Logger

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    default_tags = %{
      service: :table_check_hw,
      env: Application.get_env(:table_check_hw, :env_name, "unknown")
    }

    metrics = all(default_tags)

    children = [
      TableCheckHw.Telemetry.Poller,
      {Peep,
       [
         name: TableCheckHw.Peep,
         metrics: metrics,
         global_tags: Map.to_list(default_tags),
         statsd:
           [
             flush_interval_ms: 5000
           ] ++ statsd_opts()
       ]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def scrape() do
    Peep.get_all_metrics(TableCheckHw.Peep)
    |> Peep.Prometheus.export()
  end

  def default_tag_values_fun(default_tags, custom_tag_values_fun \\ & &1) do
    &Map.merge(default_tags, custom_tag_values_fun.(&1))
  end

  defp all(default_tags) do
    metrics(default_tags) ++ TableCheckHw.Telemetry.Poller.metrics(default_tags)
  end

  defp metrics(default_tags) do
    default_tag_keys = Map.keys(default_tags)

    [
      distribution(
        "table_check_hw.http.requests",
        event_name: [:table_check_hw, :http, :stop],
        measurement: :duration,
        unit: {:native, :microsecond},
        tag_values: default_tag_values_fun(default_tags, &http_request_tags/1),
        tags: [:method, :route, :status] ++ default_tag_keys
      )
    ]
  end

  defp http_request_tags(metadata) do
    case Map.get(metadata, :conn) do
      nil ->
        %{}

      %Plug.Conn{method: method, request_path: request_path, status: status} ->
        %{method: method, route: request_path, status: status}
    end
  end

  defp statsd_opts() do
    dd_host = Application.get_env(:table_check_hw, :dd_host, "localhost")
    dd_port = Application.get_env(:table_check_hw, :dd_port, 8125)
    Logger.info("Using UDP for StatsD metrics: #{dd_host}:#{dd_port}")
    [host: dd_host, port: dd_port]
  end
end
