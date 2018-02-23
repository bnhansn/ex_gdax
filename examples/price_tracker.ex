defmodule PriceTracker do
  use ExGdax.Websocket

  def start do
    start_link(["BTC-USD", "ETH-USD"], ["ticker"])
  end

  def handle_msg(msg) do
    data = Poison.decode!(msg)
    if data["type"] == "ticker" do
      product = data["product_id"]
      price = data["price"]
      IO.puts("The current #{product} price is #{price}")
    end
  end

  def handle_connect(_conn, state) do
    IO.puts "Price tracker connected!"
    {:ok, state}
  end

  def handle_disconnect(_conn, state) do
    IO.puts "Price tracker disconnected..."
    {:ok, state}
  end
end
