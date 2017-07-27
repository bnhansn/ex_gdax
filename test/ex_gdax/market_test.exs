defmodule ExGdax.MarketTest do
  use ExUnit.Case

  import TestHelper

  alias ExGdax.Market

  describe ".currencies" do
    test "returns list of currencies" do
      response = http_response([%{"id" => "ETH"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"id" => "ETH"}]} == Market.currencies()
      end
    end
  end

  describe ".time" do
    test "returns current iso time" do
      response = http_response(%{"iso" => "2017-07-24T06:04:06.126Z"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"iso" => "2017-07-24T06:04:06.126Z"}} == Market.time()
      end
    end
  end

  describe ".products" do
    test "returns list of products" do
      response = http_response([%{"id" => "ETH-USD"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"id" => "ETH-USD"}]} == Market.products()
      end
    end
  end

  describe ".order_book" do
    test "lists open orders for a product" do
      response = http_response(%{"asks" => [], "bids" => []}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"asks" => [], "bids" => []}} == Market.order_book("ETH-USD")
      end
    end

    test "lists order book at detailed level" do
      response = http_response(%{"asks" => [[], []], "bids" => [[], []]}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"asks" => [[], []], "bids" => [[], []]}} == Market.order_book("ETH-USD", 2)
      end
    end

    test "returns error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == Market.order_book("ETC-USD")
      end
    end
  end

  describe ".ticker" do
    test "returns snapshot product information" do
      response = http_response(%{"price" => "200.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"price" => "200.00"}} == Market.ticker("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == Market.order_book("ETC-USD")
      end
    end
  end

  describe ".trades" do
    test "returns list of trades for a product" do
      response = http_response([%{"price" => "200.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"price" => "200.00"}]} == Market.trades("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == Market.trades("ETC-USD")
      end
    end
  end

  describe ".historic_rates" do
    test "returns historic rates for a product" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} == Market.historic_rates("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == Market.historic_rates("ETC-USD")
      end
    end
  end

  describe ".stats" do
    test "returns 24 hour stats for a product" do
      response = http_response(%{"high" => "420.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"high" => "420.00"}} == Market.stats("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == Market.stats("ETC-USD")
      end
    end
  end
end
