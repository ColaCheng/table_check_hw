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
      extra_applications: [:logger],
      mod: {TableCheckHw.Application, []}
    ]
  end

  defp aliases do
    [
      compile: ["format", "compile"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:cowboy, "~> 2.9"}
    ]
  end
end
