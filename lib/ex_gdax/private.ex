defmodule ExGdax.Private do
  @moduledoc """
  Private endpoints for order management and account management.
  """
  import ExGdax.Api

  def list_accounts(config \\ nil) do
    get("/accounts", %{}, config)
  end

  def get_account(account_id, config \\ nil) do
    get("/accounts/#{account_id}", %{}, config)
  end

  def list_account_history(account_id, params \\ %{}, config \\ nil) do
    get("/accounts/#{account_id}/ledger", params, config)
  end

  def list_holds(account_id, params \\ %{}, config \\ nil) do
    get("/accounts/#{account_id}/holds", params, config)
  end

  def create_order(params, config \\ nil) do
    post("/orders", params, config)
  end

  def cancel_orders(config \\ nil) do
    delete("/orders", config)
  end

  def cancel_order(order_id, config \\ nil) do
    delete("/orders/#{order_id}", config)
  end

  def list_orders(params \\ %{}, config \\ nil) do
    get("/orders", params, config)
  end

  def get_order(order_id, config \\ nil) do
    get("/orders/#{order_id}", %{}, config)
  end

  def list_fills(params \\ %{}, config \\ nil) do
    get("/fills", params, config)
  end

  def list_funding(params \\ %{}, config \\ nil) do
    get("/funding", params, config)
  end

  def repay_funding(params, config \\ nil) do
    post("/funding/repay", params, config)
  end

  def margin_transfer(params, config \\ nil) do
    post("/profiles/margin-transfer", params, config)
  end

  def get_position(config \\ nil) do
    get("/position", %{}, config)
  end

  def close_position(params, config \\ nil) do
    post("/position", params, config)
  end

  def deposit_from_payment_method(params, config \\ nil) do
    post("/deposits/payment-method", params, config)
  end

  def deposit_from_coinbase(params, config \\ nil) do
    post("/deposits/coinbase-account", params, config)
  end

  def withdraw_to_payment_method(params, config \\ nil) do
    post("/withdrawals/payment-method", params, config)
  end

  def withdraw_to_coinbase(params, config \\ nil) do
    post("/withdrawals/coinbase", params, config)
  end

  def withdraw_to_crypto(params, config \\ nil) do
    post("/withdrawals/crypto", params, config)
  end

  def list_payment_methods(config \\ nil) do
    get("/payment-methods", %{}, config)
  end

  def list_coinbase_accounts(config \\ nil) do
    get("/coinbase-accounts", %{}, config)
  end

  def create_report(params, config \\ nil) do
    post("/reports", params, config)
  end

  def get_report(report_id, config \\ nil) do
    get("/reports/#{report_id}", %{}, config)
  end

  def list_trailing_volume(config \\ nil) do
    get("/users/self/trailing-volume", %{}, config)
  end

  def user_fee_rate(config \\ nil) do
    get("/fee-rates/user", %{}, config)
  end
end
