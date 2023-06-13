import Config

config :table_check_hw,
  http_port: 8080

config :logger,
  level: :info

config :table_check_hw,
  ecto_repos: [TableCheckHw.Repo]

import_config "#{config_env()}.exs"
