import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :table_check_hw, TableCheckHw.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :table_check_hw,
  env_name: System.get_env("ENV_NAME") || "unknown",
  http_port: String.to_integer(System.get_env("HTTP_PORT") || "8080")
