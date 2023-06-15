defmodule TableCheckHw.Telemetry.Poller do
  @moduledoc """
  Definitions of metrics to be emitted periodically.
  """
  import Telemetry.Metrics

  def child_spec(_) do
    args = [
      measurements: [],
      period: :timer.seconds(10),
      name: __MODULE__
    ]

    %{
      id: __MODULE__,
      start: {:telemetry_poller, :start_link, [args]}
    }
  end

  def metrics(default_tags) do
    default_tag_settings = [
      tags: Map.keys(default_tags),
      tag_values: TableCheckHw.Telemetry.default_tag_values_fun(default_tags)
    ]

    memory_tag_settings = Keyword.put(default_tag_settings, :unit, :byte)

    [
      # VM stats
      last_value("vm.memory.total", memory_tag_settings),
      last_value("vm.memory.processes", memory_tag_settings),
      last_value("vm.memory.processes_used", memory_tag_settings),
      last_value("vm.memory.system", memory_tag_settings),
      last_value("vm.memory.atom", memory_tag_settings),
      last_value("vm.memory.atom_used", memory_tag_settings),
      last_value("vm.memory.binary", memory_tag_settings),
      last_value("vm.memory.code", memory_tag_settings),
      last_value("vm.memory.ets", memory_tag_settings),
      last_value("vm.total_run_queue_lengths.total", default_tag_settings),
      last_value("vm.total_run_queue_lengths.cpu", default_tag_settings),
      last_value("vm.total_run_queue_lengths.io", default_tag_settings),
      last_value("vm.system_counts.process_count", default_tag_settings),
      last_value("vm.system_counts.atom_count", default_tag_settings),
      last_value("vm.system_counts.port_count", default_tag_settings)
    ]
  end
end
