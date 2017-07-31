defmodule ExGdax do
  @moduledoc """
  GDAX API client.
  """

  @doc """
  List known currencies.

  ## Examples

      iex> ExGdax.list_currencies()
      {:ok,
       [%{"id" => "BTC", "min_size" => "0.00000001", "name" => "Bitcoin"},
        %{"id" => "ETH", "min_size" => "0.00000001", "name" => "Ether"}, ...]}
  """
  defdelegate list_currencies, to: ExGdax.Market, as: :list_currencies

  @doc """
  Get the API server time.

  ## Examples

      iex> EcGdax.get_time()
      {:ok, %{"epoch" => 1501141821.835, "iso" => "2017-07-27T07:50:21.835Z"}}
  """
  defdelegate get_time, to: ExGdax.Market, as: :get_time

  @doc """
  Get a list of available currency pairs for trading.

  ## Examples

      iex> ExGdax.list_products()
      {:ok,
       [%{"base_currency" => "ETH", "base_max_size" => "5000",
          "base_min_size" => "0.01", "display_name" => "ETH/USD", "id" => "ETH-USD",
          "margin_enabled" => false, "quote_currency" => "USD",
          "quote_increment" => "0.01"}, ...]}
  """
  defdelegate list_products, to: ExGdax.Market, as: :list_products

  @doc """
  Get a list of open orders for a product. The amount of detail shown can be
  customized with the `level` parameter.

  ## Parameters

    Name    | Description
    :------ | :----------
    `level` | Response detail. Valid options are 1, 2, or 3.

  ## Examples

      iex> ExGdax.get_order_book("ETH-USD")
      {:ok,
       %{"asks" => [["200.42", "28.447359", 4]],
         "bids" => [["200.41", "11.35615248", 3]], "sequence" => 873754533}}

      iex> ExGdax.order_book("ETH-USD", %{level: 2})
      {:ok,
       %{"asks" => [["200.49", "73.898254", 6], ["200.5", "1.017412", 2],
          ["200.51", "0.017366", 1], ["200.52", "0.017387", 1], ...],
         "bids" => [["200.48", "0.7", 2], ["200.47", "0.01", 1],
          ["200.42", "0.76212582", 1], ["200.32", "0.2", 1], ...]}
  """
  defdelegate get_order_book(product_id, params \\ %{}), to: ExGdax.Market, as: :get_order_book

  @doc """
  Snapshot information about the last trade (tick), best bid/ask and 24h volume.

  ## Examples

      iex> ExGdax.get_ticker("ETH-USD")
      {:ok,
       %{"ask" => "200.47", "bid" => "200.46", "price" => "200.47000000",
         "size" => "2.65064800", "time" => "2017-07-27T08:00:43.697000Z",
         "trade_id" => 8430635, "volume" => "144080.88916080"}}
  """
  defdelegate get_ticker(product_id), to: ExGdax.Market, as: :get_ticker

  @doc """
  List the latest trades for a product.

  ## Parameters

  Name     | Description
  :------- | :----------
  `before` | Request page before (newer) this pagination id.
  `after`  | Request page after (older) this pagination id.
  `limit`  | Number of results per request. Maximum 100. (default 100)

  ## Examples

      iex> ExGdax.list_trades("ETH-USD")
      {:ok,
       [%{"price" => "200.65000000", "side" => "sell", "size" => "1.94831509",
          "time" => "2017-07-27T08:01:54.347Z", "trade_id" => 8430778}, ...]
  """
  defdelegate list_trades(product_id, params \\ %{}), to: ExGdax.Market, as: :list_trades

  @doc """
  Historic rates for a product. Rates are returned in grouped buckets based on
  requested `granularity`.

  ## Parameters

  Name          | Description
  :------------ | :----------
  `start`       | Start time in ISO 8601.
  `end`         | End time in ISO 8601.
  `granularity` | Desired timeslice in seconds.

  ## Examples

      iex> ExGdax.list_historic_rates("ETH-USD")
      {:ok,
       [[1501142880, 200.43, 200.43, 200.43, 200.43, 5.6956], ...]}
  """
  defdelegate list_historic_rates(product_id, params \\ %{}), to: ExGdax.Market, as: :list_historic_rates

  @doc """
  Get 24 hr stats for the product. `volume` is in base currency units. `open`,
  `high`, `low` are in quote currency units.

  ## Examples

      iex> ExGdax.get_stats("ETH-USD")
      {:ok,
       %{"high" => "205.80000000", "last" => "201.68000000", "low" => "194.42000000",
         "open" => "197.97000000", "volume" => "143965.79255890",
         "volume_30day" => "9270459.77394214"}}
  """
  defdelegate get_stats(product_id), to: ExGdax.Market, as: :get_stats

  @doc """
  List accounts.

  ## Examples

      iex> ExGdax.list_accounts()
      {:ok,
       [%{"available" => "0.0000000000000000", "balance" => "0.0000000000000000",
          "currency" => "USD", "hold" => "0.0000000000000000",
          "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
          "profile_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}, ...]}
  """
  defdelegate list_accounts, to: ExGdax.Private, as: :list_accounts

  @doc """
  Get an account.

  ## Examples

    iex> ExGdax.get_account(account["id"])
    {:ok,
     %{"available" => "0.0000000000000000", "balance" => "0.0000000000000000",
        "currency" => "USD", "hold" => "0.0000000000000000",
        "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
        "profile_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}}
  """
  defdelegate get_account(account_id), to: ExGdax.Private, as: :get_account

  @doc """
  List activity for an account.

  ## Parameters

  Name     | Description
  :------- | :----------
  `before` | Request page before (newer) this pagination id.
  `after`  | Request page after (older) this pagination id.
  `limit`  | Number of results per request. Maximum 100. (default 100)

  ## Examples

      iex> ExGdax.list_account_history(account["id"])
      {:ok,
       [%{"amount" => "0.0000000000000000", "balance" => "0.0000000000000000",
          "created_at" => "2017-07-08T15:26:17.04917Z",
          "details" => %{"transfer_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
            "transfer_type" => "withdraw"}, "id" => XXXXXXXX, "type" => "transfer"}, ...]}
  """
  defdelegate list_account_history(account_id, params \\ %{}), to: ExGdax.Private, as: :list_account_history

  @doc """
  Lists holds on an account for active orders or withdraw requests.

  ## Parameters

  Name     | Description
  :------- | :----------
  `before` | Request page before (newer) this pagination id.
  `after`  | Request page after (older) this pagination id.
  `limit`  | Number of results per request. Maximum 100. (default 100)

  ## Examples

      iex> ExGdax.list_holds(account["id"])
      {:ok, []}
  """
  defdelegate list_holds(account_id, params \\ %{}), to: ExGdax.Private, as: :list_holds

  @doc """
  Place a new order.

  Refer to params listed here https://docs.gdax.com/#place-a-new-order
  """
  defdelegate create_order(params), to: ExGdax.Private, as: :create_order

  @doc """
  Cancel all open orders.

  ## Examples

      iex> ExGdax.cancel_orders()
      {:ok, []}
  """
  defdelegate cancel_orders, to: ExGdax.Private, as: :cancel_orders

  @doc """
  List open orders.

  ## Parameters

  Name         | Default                 | Description
  :----------- | :---------------------- | :----------
  `status`     | [open, pending, active] | Limit list of orders to these statuses.
  `product_id` |                         | Only list orders for a specific product.
  `before`     |                         | Request page before (newer) this pagination id.
  `after`      |                         | Request page after (older) this pagination id.
  `limit`      |                         | Number of results per request. Maximum 100. (default 100)

  ## Examples

      iex> ExGdax.list_orders()
      {:ok, []}
  """
  defdelegate list_orders(params \\ %{}), to: ExGdax.Private, as: :list_orders

  @doc """
  Get an order.
  """
  defdelegate get_order(order_id), to: ExGdax.Private, as: :get_order

  @doc """
  Get a list of recent fills.

  ## Parameters

  Name         | Description
  :----------- | :----------
  `order_id`   | Limit list of fills to this order_id.
  `product_id` | Limit list of fills to this product_id.
  `before`     | Request page before (newer) this pagination id.
  `after`      | Request page after (older) this pagination id.
  `limit`      | Number of results per request. Maximum 100. (default 100)
  """
  defdelegate list_fills(params \\ %{}), to: ExGdax.Private, as: :list_fills

  @doc """
  List funding records.

  ## Parameters

  Name     | Options                           | Description
  :------- | :-------------------------------- | :----------
  `status` | outstanding, settled, or rejected | Limit list of funding records to these statuses.
  `before` |                                   | Request page before (newer) this pagination id.
  `after`  |                                   | Request page after (older) this pagination id.
  `limit`  |                                   | Number of results per request. Maximum 100. (default 100)
  """
  defdelegate list_funding(params \\ %{}), to: ExGdax.Private, as: :list_funding

  @doc """
  Repay funding. Repays the older funding records first.

  ## Parameters

  Name       | Description
  :--------- | :----------
  `amount`   | Amount of currency to repay.
  `currency` | The currency, example `USD`.
  """
  defdelegate repay_funding(params), to: ExGdax.Private, as: :repay_funding

  @doc """
  Transfer funds between your standard/default profile and a margin profile.

  ## Parameters

  Name                | Description
  :------------------ | :----------
  `margin_profile_id` | The id of the margin profile you’d like to deposit to or withdraw from.
  `type`              | `deposit` or `withdraw`.
  `currency`          | The currency to transfer, ex: `BTC` or `USD`.
  `amount`            | The amount to transfer between the default and margin profile.
  """
  defdelegate margin_transfer(params), to: ExGdax.Private, as: :margin_transfer

  @doc """
  An overview of your profile.

  ## Examples

      iex> ExGdax.get_position()
      {:ok,
       %{"accounts" => %{"BTC" => %{"balance" => "0.0000000000000000",
             "default_amount" => "0", "funded_amount" => "0",
             "hold" => "0.0000000000000000",
             "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"},
           "ETH" => %{"balance" => "0.0000000000000000", "default_amount" => "0",
             "funded_amount" => "0", "hold" => "0.0000000000000000",
             "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"},
           "LTC" => %{"balance" => "0.0000000000000000", "default_amount" => "0",
             "funded_amount" => "0", "hold" => "0.0000000000000000",
             "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"},
           "USD" => %{"balance" => "0.0000000000000000", "default_amount" => "0",
             "funded_amount" => "0", "hold" => "0.0000000000000000",
             "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}},
         "profile_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX", "status" => "active",
         "user_id" => "XXXXXXXXXXXXXXXXXXXXXXXX"}}
  """
  defdelegate get_position, to: ExGdax.Private, as: :get_position

  @doc """
  Close your position.

  ## Parameters

  Name         | Description
  :----------- | :----------
  `repay_only` | Either `true` or `false`
  """
  defdelegate close_position(params), to: ExGdax.Private, as: :close_position

  @doc """
  Deposit funds from a coinbase account.

  ## Parameters

  Name                  | Description
  :-------------------- | :----------
  `amount`              | The amount to deposit.
  `currency`            | The type of currency.
  `coinbase_account_id` | ID of the coinbase account.
  """
  defdelegate deposit_from_coinbase(params), to: ExGdax.Private, as: :deposit_from_coinbase

  @doc """
  Withdraw funds to a payment method.

  ## Parameters

  Name                | Description
  :------------------ | :----------
  `amount`            | The amount to withdraw.
  `currency`          | The type of currency.
  `payment_method_id` | ID of the payment method.
  """
  defdelegate withdraw_to_payment_method(params), to: ExGdax.Private, as: :withdraw_to_payment_method

  @doc """
  Withdraw funds to a coinbase account.

  ## Parameters

  Name                  | Description
  :-------------------- | :----------
  `amount`              | The amount to withdraw.
  `currency`            | The type of currency.
  `coinbase_account_id` | ID of the coinbase account.
  """
  defdelegate withdraw_to_coinbase(params), to: ExGdax.Private, as: :withdraw_to_coinbase

  @doc """
  Withdraw funds to a crypto address.

  ## Parameters

  Name             | Description
  :--------------- | :----------
  `amount`         | The amount to withdraw.
  `currency`       | The type of currency.
  `crypto_address` | A crypto address of the recipient.
  """
  defdelegate withdraw_to_crypto(params), to: ExGdax.Private, as: :withdraw_to_crypto

  @doc """
  List your payment methods.

  ## Examples

      iex> ExGdax.list_payment_methods()
      {:ok,
       [%{"allow_buy" => false, "allow_deposit" => true, "allow_sell" => true,
          "allow_withdraw" => false, "created_at" => "2015-11-03T00:32:02Z",
          "currency" => "USD",
          "fiat_account" => %{"id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
            "resource" => "account",
            "resource_path" => "/v2/accounts/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}, ...]}
  """
  defdelegate list_payment_methods, to: ExGdax.Private, as: :list_payment_methods

  @doc """
  List your coinbase accounts.

  ## Examples

      iex> ExGdax.list_coinbase_accounts()
      {:ok,
       [%{"active" => true, "balance" => "0.00000000", "currency" => "ETH",
          "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX", "name" => "ETH Wallet",
          "primary" => false, "type" => "wallet"}, ...]}
  """
  defdelegate list_coinbase_accounts, to: ExGdax.Private, as: :list_coinbase_accounts

  @doc """
  Create a report.

  ## Parameters

  Name         | Description
  :----------- | :----------
  `type`       | `fills` or `account`.
  `start_date` | Starting date for the report (inclusive).
  `end_date`   | Ending date for the report (inclusive).
  `product_id` | ID of the product to generate a fills report for. E.g. BTC-USD. Required if `type` is `fills`.
  `account_id` | ID of the account to generate an account report for. Required if `type` is `account`.
  `format`     | `pdf` or `csv` (defualt is `pdf`).
  `email`      | Email address to send the report to (optional).
  """
  defdelegate create_report(params), to: ExGdax.Private, as: :create_report

  @doc """
  Get report status.
  """
  defdelegate get_report(report_id), to: ExGdax.Private, as: :get_report

  @doc """
  List your 30-day trailing volume for all products.

  ## Examples

      iex> ExGdax.list_trailing_volume()
      {:ok,
       [%{"exchange_volume" => "8704829.60943332", "product_id" => "ETH-USD",
          "recorded_at" => "2017-07-31T00:17:16.331884Z", "volume" => "1.00000000"}]}
  """
  defdelegate list_trailing_volume, to: ExGdax.Private, as: :list_trailing_volume
end
