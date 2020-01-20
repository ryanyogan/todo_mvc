# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_mvc,
  namespace: TodoMVC

# Configures the endpoint
config :todo_mvc, TodoMVCWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RoFFAOllvPMZ6Fpzc5O+/KWftQr7l40oD1Ki1Zgn0AO9VsbZSuwCP0ZEbnfTm1Iq",
  render_errors: [view: TodoMVCWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TodoMVC.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "6wZlMP9YHtPmB+t9ltgFpV2+dTOz0R7z"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
