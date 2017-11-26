defmodule ExGdax.Private do
  @moduledoc """
  Private endpoints for order management and account management.
  """
  import ExGdax.Api

  def list_accounts do
    get("/accounts")
  end

  def get_account(account_id) do
    get("/accounts/#{account_id}")
  end

  def list_account_history(account_id, params \\ %{}) do
    get("/accounts/#{account_id}/ledger", params)
  end

  def list_holds(account_id, params \\ %{}) do
    get("/accounts/#{account_id}/holds", params)
  end

  def create_order(params) do
    post("/orders", params)
  end

  def cancel_orders do
    delete("/orders")
  end

  def cancel_orders(order_id) do
    delete("/orders/#{order_id}")
  end

  def list_orders(params \\ %{}) do
    get("/orders", params)
  end

  def get_order(order_id) do
    get("/orders/#{order_id}")
  end

  def list_fills(params \\ %{}) do
    get("/fills", params)
  end

  def list_funding(params \\ %{}) do
    get("/funding", params)
  end

  def repay_funding(params) do
    post("/funding/repay", params)
  end

  def margin_transfer(params) do
    post("/profiles/margin-transfer", params)
  end

  def get_position do
    get("/position")
  end

  def close_position(params) do
    post("/position", params)
  end

  def deposit_from_payment_method(params) do
    post("/deposits/payment-method", params)
  end

  def deposit_from_coinbase(params) do
    post("/deposits/coinbase-account", params)
  end

  def withdraw_to_payment_method(params) do
    post("/withdrawals/payment-method", params)
  end

  def withdraw_to_coinbase(params) do
    post("/withdrawals/coinbase", params)
  end

  def withdraw_to_crypto(params) do
    post("/withdrawals/crypto", params)
  end

  def list_payment_methods do
    get("/payment-methods")
  end

  def list_coinbase_accounts do
    get("/coinbase-accounts")
  end

  def create_report(params) do
    post("/reports", params)
  end

  def get_report(report_id) do
    get("/reports/#{report_id}")
  end

  def list_trailing_volume do
    get("/users/self/trailing-volume")
  end
end
