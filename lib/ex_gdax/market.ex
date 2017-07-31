defmodule ExGdax.Market do
  @moduledoc """
  Unauthenticated endpoints for retrieving market data.
  """
  import ExGdax.Api

  def list_currencies do
    get("/currencies")
  end

  def get_time do
    get("/time")
  end

  def list_products do
    get("/products")
  end

  def get_order_book(product_id, params \\ %{}) do
    get("/products/#{product_id}/book", params)
  end

  def get_ticker(product_id) do
    get("/products/#{product_id}/ticker")
  end

  def list_trades(product_id, params \\ %{}) do
    get("/products/#{product_id}/trades", params)
  end

  def list_historic_rates(product_id, params \\ %{}) do
    get("/products/#{product_id}/candles", params)
  end

  def get_stats(product_id) do
    get("/products/#{product_id}/stats")
  end
end
