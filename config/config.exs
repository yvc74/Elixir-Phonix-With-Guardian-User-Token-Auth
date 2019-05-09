# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :appp,
  ecto_repos: [Appp.Repo]

# Configures the endpoint
config :appp, ApppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FIGx/ul1hIHtr0hWn0z79id+02MZyCODBWknKdIdu+IJ5rWkgmEMhGM9129yAhDS",
  render_errors: [view: ApppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Appp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :appp, Appp.Guardian,
  issuer: "appp",
  secret_key: "Add Your Secret Key Using mix phx.gen.secret"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
