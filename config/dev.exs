use Mix.Config

# Read from environment variables
config :ex_gdax, api_key:        System.get_env("GDAX_API_KEY"),
                 api_secret:     System.get_env("GDAX_API_SECRET"),
                 api_passphrase: System.get_env("GDAX_API_PASSPHRASE")

# Or replace "GDAX_*" values to define here in config file
# config :ex_gdax, api_key:        {:system, "GDAX_API_KEY"},
#                  api_secret:     {:system, "GDAX_API_SECRET"},
#                  api_passphrase: {:system, "GDAX_API_PASSPHRASE"}
