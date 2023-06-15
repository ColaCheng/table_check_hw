import Config

config :table_check_hw,
  env_name: System.get_env("ENV_NAME") || "unknown"
