# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ahpta,
  ecto_repos: [Ahpta.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :ahpta, AhptaWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: AhptaWeb.ErrorHTML, json: AhptaWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Ahpta.PubSub,
  live_view: [signing_salt: "pk6XfiLc"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ahpta, Ahpta.Mailer, adapter: Swoosh.Adapters.Local

config :ahpta, :chat_module, ExOpenAI.Chat

config :qdrant,
  port: 6333,
  interface: "rest",
  database_url: System.get_env("QDRANT_DATABASE_URL"),
  api_key: System.get_env("QDRANT_API_KEY")

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_openai,
  api_key: System.get_env("OPENAI_API_KEY"),
  organization_key: System.get_env("OPENAI_ORGANIZATION_KEY"),
  http_options: [recv_timeout: 50_000]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
