defmodule ExGdax.Market do
  @moduledoc """
  Unauthenticated endpoints for retrieving market data.
  """
  alias ExGdax.Api

  @doc """
  List known currencies.

  ## Examples

      iex> ExGdax.Market.currencies()
      {:ok,
       [%{"id" => "BTC", "min_size" => "0.00000001", "name" => "Bitcoin"},
        %{"id" => "ETH", "min_size" => "0.00000001", "name" => "Ether"}, ...]}
  """
  def currencies do
    Api.get("/currencies")
  end

  @doc """
  Get the API server time.

  ## Examples

      iex> EcGdax.Market.time()
      {:ok, %{"epoch" => 1501141821.835, "iso" => "2017-07-27T07:50:21.835Z"}}
  """
  def time do
    Api.get("/time")
  end

  @doc """
  Get a list of available currency pairs for trading.

  ## Examples

      iex> ExGdax.Market.products()
      {:ok,
       [%{"base_currency" => "ETH", "base_max_size" => "5000",
          "base_min_size" => "0.01", "display_name" => "ETH/USD", "id" => "ETH-USD",
          "margin_enabled" => false, "quote_currency" => "USD",
          "quote_increment" => "0.01"}, ...]}
  """
  def products do
    Api.get("/products")
  end

  @doc """
  Get a list of open orders for a product. The amount of detail shown can be
  customized with the `level` parameter.

  ## Parameters

    Name    | Description
    :------ | :----------
    `level` | Response detail. Valid options are 1, 2, or 3.

  ## Examples

      iex> ExGdax.Market.order_book("ETH-USD")
      {:ok,
       %{"asks" => [["200.42", "28.447359", 4]],
         "bids" => [["200.41", "11.35615248", 3]], "sequence" => 873754533}}

      iex> ExGdax.Market.order_book("ETH-USD", %{level: 2})
      {:ok,
       %{"asks" => [["200.49", "73.898254", 6], ["200.5", "1.017412", 2],
          ["200.51", "0.017366", 1], ["200.52", "0.017387", 1], ...],
         "bids" => [["200.48", "0.7", 2], ["200.47", "0.01", 1],
          ["200.42", "0.76212582", 1], ["200.32", "0.2", 1], ...]}
  """
  def order_book(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/book", params)
  end

  @doc """
  Snapshot information about the last trade (tick), best bid/ask and 24h volume.

  ## Examples

      iex> ExGdax.Market.ticker("ETH-USD")
      {:ok,
       %{"ask" => "200.47", "bid" => "200.46", "price" => "200.47000000",
         "size" => "2.65064800", "time" => "2017-07-27T08:00:43.697000Z",
         "trade_id" => 8430635, "volume" => "144080.88916080"}}
  """
  def ticker(product_id) do
    Api.get("/products/#{product_id}/ticker")
  end

  @doc """
  List the latest trades for a product.

  ## Parameters

  Name     | Description
  :------- | :----------
  `before` | Request page before (newer) this pagination id.
  `after`  | Request page after (older) this pagination id.
  `limit`  | Number of results per request. Maximum 100. (default 100)

  ## Examples

      iex> ExGdax.Market.trades("ETH-USD")
      {:ok,
       [%{"price" => "200.65000000", "side" => "sell", "size" => "1.94831509",
          "time" => "2017-07-27T08:01:54.347Z", "trade_id" => 8430778}, ...]
  """
  def trades(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/trades", params)
  end

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

      iex> ExGdax.Market.historic_rates("ETH-USD")
      {:ok,
       [[1501142880, 200.43, 200.43, 200.43, 200.43, 5.6956], ...]}
  """
  def historic_rates(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/candles", params)
  end

  @doc """
  Get 24 hr stats for the product. `volume` is in base currency units. `open`,
  `high`, `low` are in quote currency units.

  ## Examples

      iex> ExGdax.Market.stats("ETH-USD")
      {:ok,
       %{"high" => "205.80000000", "last" => "201.68000000", "low" => "194.42000000",
         "open" => "197.97000000", "volume" => "143965.79255890",
         "volume_30day" => "9270459.77394214"}}
  """
  def stats(product_id) do
    Api.get("/products/#{product_id}/stats")
  end
end
