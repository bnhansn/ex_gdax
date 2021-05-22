# ExGdax
[![Build Status](https://github.com/bnhansn/ex_gdax/workflows/test/badge.svg?branch=main)](https://github.com/bnhansn/ex_gdax/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/ex_gdax.svg?style=flat)](https://hex.pm/packages/ex_gdax)

GDAX API client for Elixir.

## Installation

List the Hex package in your application dependencies.

```elixir
def deps do
  [{:ex_gdax, "~> 0.2"}]
end
```

Run `mix deps.get` to install.

## Configuration

Add the following configuration variables in your config/config.exs file:

```elixir
use Mix.Config

config :ex_gdax, api_key:        {:system, "GDAX_API_KEY"},
                 api_secret:     {:system, "GDAX_API_SECRET"},
                 api_passphrase: {:system, "GDAX_API_PASSPHRASE"},
                 api_url:        {:system. "GDAX_API_URL"} # optional
```

Alternatively to hard coding credentials, the recommended approach is
to use environment variables as follows:

```elixir
use Mix.Config

config :ex_gdax, api_key:        System.get_env("GDAX_API_KEY"),
                 api_secret:     System.get_env("GDAX_API_SECRET"),
                 api_passphrase: System.get_env("GDAX_API_PASSPHRASE")
```

Alternatively, if you need to work with multiple GDAX accounts, the private API
call functions accept an additional `config` (`ExGdax.Config` struct) parameter:

```elixir
config = %ExGdax.Config{
  api_key: "API_KEY",
  api_secret: "API_SECRET",
  api_passphrase: "API_PASSPHRASE",
  api_url: "API_URL" # optional
}
ExGdax.list_accounts() # use config as specified in config.exs
ExGdax.list_accounts(config) # use the passed config struct param
```

## Usage

Place a limit order

```elixir
iex> ExGdax.create_order(%{type: "limit", side: "buy", product_id: "ETH-USD", price: "200", size: "1.0"})
{:ok,
 %{"created_at" => "2017-08-20T23:29:17.752637Z",
   "executed_value" => "0.0000000000000000",
   "fill_fees" => "0.0000000000000000", "filled_size" => "0.00000000",
   "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX", "post_only" => false,
   "price" => "200.00000000", "product_id" => "ETH-USD",
   "settled" => false, "side" => "buy", "size" => "1.00000000",
   "status" => "pending", "stp" => "dc", "time_in_force" => "GTC",
   "type" => "limit"}}
```

Withdraw to crypto address

```elixir
iex> ExGdax.withdraw_to_crypto(%{currency: "ETH", amount: "0.1", crypto_address: "0x30a9f8b57e2dcb519a4e4982ed6379f9dd6a0bfc"})
{:ok,
 %{"amount" => "0.10000000", "currency" => "ETH",
   "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}}
```

May the charts be ever in your favor 📈😊

## Additional Links

[Full Documentation](https://hexdocs.pm/ex_gdax/ExGdax.html)

[GDAX API Docs](https://docs.gdax.com)

## License

MIT

## TODO
- [ ] Websocket client
