use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bathroom_finder, BathroomFinderWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bathroom_finder, BathroomFinder.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bathroom_finder_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
