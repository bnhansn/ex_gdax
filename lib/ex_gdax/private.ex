defmodule ExGdax.Private do
  @moduledoc """
  Private endpoints for order management and account management.
  """
  alias ExGdax.Api

  @doc """
  List accounts.

  ## Examples

      iex> ExGdax.Private.list_accounts()
      {:ok,
       [%{"available" => "0.0000000000000000", "balance" => "0.0000000000000000",
          "currency" => "USD", "hold" => "0.0000000000000000",
          "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
          "profile_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}, ...]}
  """
  def list_accounts do
    Api.get("/accounts")
  end

  @doc """
  Get an account.

  ## Examples

    iex> ExGdax.Private.get_account(account["id"])
    {:ok,
     %{"available" => "0.0000000000000000", "balance" => "0.0000000000000000",
        "currency" => "USD", "hold" => "0.0000000000000000",
        "id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
        "profile_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"}}
  """
  def get_account(account_id) do
    Api.get("/accounts/#{account_id}")
  end

  @doc """
  List account activity.

  ## Examples

      iex> ExGdax.Private.get_account_history(account["id"])
      {:ok,
       [%{"amount" => "0.0000000000000000", "balance" => "0.0000000000000000",
          "created_at" => "2017-07-08T15:26:17.04917Z",
          "details" => %{"transfer_id" => "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
            "transfer_type" => "withdraw"}, "id" => XXXXXXXX, "type" => "transfer"}, ...]}
  """
  def get_account_history(account_id) do
    Api.get("/accounts/#{account_id}/ledger")
  end

  @doc """
  Lists holds on an account for active orders or withdraw requests.

  ## Examples

      iex> ExGdax.Private.get_holds(account["id"])
      {:ok, []}
  """
  def get_holds(account_id) do
    Api.get("/accounts/#{account_id}/holds")
  end

  @doc """
  Place a new order.
  """
  def create_order(params \\ %{}) do
    Api.post("/orders", params)
  end

  @doc """
  Cancel all open orders.

  ## Examples

      iex> ExGdax.Private.cancel_orders()
      {:ok, []}
  """
  def cancel_orders do
    Api.delete("/orders")
  end
end
