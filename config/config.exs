use Mix.Config

config :ex_gdax, api_key:        {:system, "GDAX_API_KEY"},
                 api_secret:     {:system, "GDAX_API_SECRET"},
                 api_passphrase: {:system, "GDAX_API_PASSHPRASE"},
                 api_url:        {:system, "GDAX_API_URL"}
