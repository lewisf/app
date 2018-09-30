# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :app,
  ecto_repos: [App.Repo],
  env: Mix.env

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HhpIaU8F76KPcWaPntAylwnu24Xwvki1837TKYhM7q+66+H/KnllkpnLLrKiv71X",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Guardian for authentication
config :app, AppWeb.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "ShopWithApp",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  # generated using: JOSE.JWK.generate_key({:oct, 16}) |> JOSE>JWK.to_map |> elem(1)
  secret_key: %{"k" => "_k-84hJ27xK09mxSbLCHqg", "kty" => "oct"},
  serializer: AppWeb.Guardian

config :ex_admin,
  repo: App.Repo,
  module: AppWeb,
  modules: [
    App.ExAdmin.Dashboard,
    App.ExAdmin.Accounts.User
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :gettext,
  default_locale: "en/us"

config :ex_twilio,
  account_sid: {:system, "TWILIO_ACCOUNT_SID"},
  auth_token: {:system, "TWILIO_AUTH_TOKEN"},
  workspace_sid: {:system, "TWILIO_WORKSPACE_SID"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}
