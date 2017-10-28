defmodule ExGdaxTest do
  use ExUnit.Case

  import TestHelper

  describe ".list_currencies" do
    test "returns list of currencies" do
      response = http_response([%{"id" => "ETH"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"id" => "ETH"}]} == ExGdax.list_currencies()
      end
    end
  end

  describe ".get_time" do
    test "returns current iso time" do
      response = http_response(%{"iso" => "2017-07-24T06:04:06.126Z"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"iso" => "2017-07-24T06:04:06.126Z"}} == ExGdax.get_time()
      end
    end
  end

  describe ".list_products" do
    test "returns list of products" do
      response = http_response([%{"id" => "ETH-USD"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"id" => "ETH-USD"}]} == ExGdax.list_products()
      end
    end
  end

  describe ".get_order_book" do
    test "lists open orders for a product" do
      response = http_response(%{"asks" => [], "bids" => []}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"asks" => [], "bids" => []}} == ExGdax.get_order_book("ETH-USD")
      end
    end

    test "lists order book at detailed level" do
      response = http_response(%{"asks" => [[], []], "bids" => [[], []]}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"asks" => [[], []], "bids" => [[], []]}} == ExGdax.get_order_book("ETH-USD", %{level: 2})
      end
    end

    test "returns error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == ExGdax.get_order_book("ETC-USD")
      end
    end
  end

  describe ".get_ticker" do
    test "returns snapshot product information" do
      response = http_response(%{"price" => "200.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"price" => "200.00"}} == ExGdax.get_ticker("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == ExGdax.get_ticker("ETC-USD")
      end
    end
  end

  describe ".list_trades" do
    test "returns list of trades for a product" do
      response = http_response([%{"price" => "200.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"price" => "200.00"}]} == ExGdax.list_trades("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == ExGdax.list_trades("ETC-USD")
      end
    end
  end

  describe ".list_historic_rates" do
    test "returns historic rates for a product" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} == ExGdax.list_historic_rates("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == ExGdax.list_historic_rates("ETC-USD")
      end
    end
  end

  describe ".get_stats" do
    test "returns 24 hour stats for a product" do
      response = http_response(%{"high" => "420.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"high" => "420.00"}} == ExGdax.get_stats("ETH-USD")
      end
    end

    test "return error when resource does not exist" do
      response = http_response(%{"message" => "Resource not found"}, 404)

      with_mock_request :get, response, fn ->
        assert {:error, "Resource not found", 404} == ExGdax.get_stats("ETC-USD")
      end
    end
  end

  describe ".list_accounts" do
    test "returns list of accounts" do
      response = http_response([%{"balance" => "0.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"balance" => "0.00"}]} = ExGdax.list_accounts()
      end
    end

    test "accepts dynamically specified config" do
      config = %ExGdax.Config{
        api_key: "GDAX_API_KEY",
        api_secret: Base.encode64("GDAX_API_SECRET"),
        api_passphrase: "GDAX_API_PASSPHRASE"
      }
      response = http_response([%{"balance" => "0.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"balance" => "0.00"}]} = ExGdax.list_accounts(config)
      end
    end
  end

  describe ".get_account" do
    test "returns account" do
      response = http_response(%{"balance" => "0.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"balance" => "0.00"}} = ExGdax.get_account("xxx")
      end
    end
  end

  describe ".list_account_history" do
    test "returns list of account transactions" do
      response = http_response([%{"amount" => "0.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"amount" => "0.00"}]} = ExGdax.list_account_history("xxx")
      end
    end
  end

  describe ".list_holds" do
    test "returns list of holds on account" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_holds("xxx")
      end
    end
  end

  describe ".create_order" do
    test "returns placed order" do
      response = http_response(%{"price" => "1.00"}, 201)

      with_mock_request :post, response, fn ->
        assert {:ok, %{"price" => "1.00"}} =
          ExGdax.create_order(%{side: "buy", product_id: "ETH-USD", price: "1.00"})
      end
    end
  end

  describe ".cancel_orders" do
    test "cancels all open orders" do
      response = http_response([], 200)

      with_mock_request :delete, response, fn ->
        assert {:ok, []} = ExGdax.cancel_orders()
      end
    end
  end

  describe ".list_orders" do
    test "returns list of open orders" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_orders()
      end
    end
  end

  describe ".get_order" do
    test "returns open order" do
      response = http_response(%{}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{}} = ExGdax.get_order("xxx")
      end
    end
  end

  describe ".list_fills" do
    test "returns list of recent fills" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_fills()
      end
    end
  end

  describe ".list_funding" do
    test "returns list of funding records" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_funding()
      end
    end
  end

  describe ".repay_funding" do
    test "makes post request to repay funding record" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.repay_funding(%{amount: "1.00", currency: "USD"})
      end
    end
  end

  describe ".margin_transfer" do
    test "transfers funds to margin profile" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.margin_transfer(%{
          margin_profile_id: "xxx", type: "deposit", currency: "USD", amount: "1.00"})
      end
    end
  end

  describe ".get_position" do
    test "returns overview of profile" do
      response = http_response(%{}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{}} = ExGdax.get_position()
      end
    end
  end

  describe ".close_position" do
    test "closes profile position" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.close_position(%{repay_only: true})
      end
    end
  end

  describe ".deposit_from_coinbase" do
    test "moves funds from coinbase to gdax" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.deposit_from_coinbase(%{
          amount: "1.00", currency: "ETH", coinbase_account_id: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"})
      end
    end
  end

  describe ".withdraw_to_payment_method" do
    test "withdraws funds to payment method" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.withdraw_to_payment_method(%{
          amount: "1.00", currency: "USD", payment_method_id: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"})
      end
    end
  end

  describe ".withdraw_to_coinbase" do
    test "withdraws funds to coinbase account" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.withdraw_to_coinbase(%{
          amount: "1.00", currency: "BTC", coinbase_account_id: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"})
      end
    end
  end

  describe ".withdraw_to_crypto" do
    test "withdraws funds to a crypto address" do
      response = http_response(%{}, 200)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.withdraw_to_crypto(%{
          amount: "1.00", currency: "ETH", crypto_address: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"})
      end
    end
  end

  describe ".list_payment_methods" do
    test "returns list of payment methods" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_payment_methods()
      end
    end
  end

  describe ".list_coinbase_accounts" do
    test "returns list of coinbase accounts" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_coinbase_accounts()
      end
    end
  end

  describe ".create_report" do
    test "creates a report" do
      response = http_response(%{}, 201)

      with_mock_request :post, response, fn ->
        assert {:ok, %{}} = ExGdax.create_report(%{})
      end
    end
  end

  describe ".get_report" do
    test "returns the report status" do
      response = http_response(%{}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{}} = ExGdax.get_report("xxx")
      end
    end
  end

  describe ".list_trailing_volume" do
    test "returns the report status" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = ExGdax.list_trailing_volume()
      end
    end
  end
end
