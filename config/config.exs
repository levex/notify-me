# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :notify_me,
  ecto_repos: [NotifyMe.Repo]

# Configures the endpoint
config :notify_me, NotifyMeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bevhKJn97jdVY+bwhfvprNH5A84Z8F2St3NqEtgC6evfyEjMOzDO1KTce+sth20C",
  render_errors: [view: NotifyMeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NotifyMe.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
