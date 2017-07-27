defmodule ExGdax.PrivateTest do
  use ExUnit.Case

  import TestHelper

  alias ExGdax.Private

  describe ".list_accounts" do
    test "returns list of accounts" do
      response = http_response([%{"balance" => "0.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"balance" => "0.00"}]} = Private.list_accounts()
      end
    end
  end

  describe ".get_account" do
    test "return account" do
      response = http_response(%{"balance" => "0.00"}, 200)

      with_mock_request :get, response, fn ->
        assert {:ok, %{"balance" => "0.00"}} = Private.get_account("xxxx")
      end
    end
  end

  describe ".get_account_history" do
    test "returns list of account transactions" do
      response = http_response([%{"amount" => "0.00"}], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, [%{"amount" => "0.00"}]} = Private.get_account_history("xxxx")
      end
    end
  end

  describe ".get_holds" do
    test "returns list holds on account" do
      response = http_response([], 200)

      with_mock_request :get, response, fn ->
        assert {:ok, []} = Private.get_holds("xxxx")
      end
    end
  end

  describe ".create_order" do
    test "returns placed order" do
      response = http_response(%{"price" => "1.00"}, 201)

      with_mock_request :post, response, fn ->
        assert {:ok, %{"price" => "1.00"}} =
          Private.create_order(%{side: "buy", product_id: "ETH-USD", price: "1.00"})
      end
    end
  end

  describe ".cancel_orders" do
    test "cancels all open orders" do
      response = http_response([], 200)

      with_mock_request :delete, response, fn ->
        assert {:ok, []} = Private.cancel_orders()
      end
    end
  end
end
