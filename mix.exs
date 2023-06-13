defmodule TableCheckHw.MixProject do
  use Mix.Project

  def project do
    [
      app: :table_check_hw,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {TableCheckHw.Application, []}
    ]
  end

  defp aliases do
    [
      compile: ["format", "compile"],
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:cowboy, "~> 2.9"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
