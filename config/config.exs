import Config

config :table_check_hw,
  http_port: 8080

config :logger,
  level: :info

import_config "#{config_env()}.exs"
