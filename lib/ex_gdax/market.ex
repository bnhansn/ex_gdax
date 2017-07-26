defmodule ExGdax.Market do
  @moduledoc """
  Unauthenticated endpoints for retrieving market data.
  """
  alias ExGdax.Api

  @doc """
  List known currencies.

  Returns {:ok, currencies}
  """
  def currencies do
    Api.get("/currencies")
  end

  @doc """
  Get the API server time.

  Returns {:ok, time}
  """
  def time do
    Api.get("/time")
  end

  @doc """
  Get a list of available currency pairs for trading.

  Returns {:ok, products}.
  """
  def products do
    Api.get("/products")
  end

  @doc """
  Get a list of open orders for a product. The amount of detail shown can be
  customized with the `level` parameter.

  ## Parameters
    level - Response detail. Valid options are 1, 2, or 3.

  Returns {:ok, orders}
  """
  def order_book(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/book", params)
  end

  @doc """
  Snapshot information about the last trade (tick), best bid/ask and 24h volume.

  Returns {:ok, ticker}
  """
  def ticker(product_id) do
    Api.get("/products/#{product_id}/ticker")
  end

  @doc """
  List the latest trades for a product.

  ## Parameters
    before - Request page before (newer) this pagination id.
    after - Request page after (older) this pagination id.
    limit - Number of results per request. Maximum 100. (default 100)

  Returns {:ok, trades}.
  """
  def trades(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/trades", params)
  end

  @doc """
  Historic rates for a product. Rates are returned in grouped buckets based on
  requested `granularity`.

  ## Parameters
    start - Start time in ISO 8601.
    end - End time in ISO 8601.
    granularity - Desired timeslice in seconds.

  Returns {:ok, candles}
  """
  def historic_rates(product_id, params \\ %{}) do
    Api.get("/products/#{product_id}/candles", params)
  end

  @doc """
  Get 24 hr stats for the product. `volume` is in base currency units. `open`,
  `high`, `low` are in quote currency units.

  Returns {:ok, stats}
  """
  def stats(product_id) do
    Api.get("/products/#{product_id}/stats")
  end
end
