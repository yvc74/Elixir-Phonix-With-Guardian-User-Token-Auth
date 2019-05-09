use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :appp, ApppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :appp, Appp.Repo,
  username: "postgres",
  password: "postgres",
  database: "appp_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
