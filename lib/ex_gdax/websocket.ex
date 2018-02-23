defmodule ExGdax.Websocket do
  @moduledoc """
  Implements behaviour to stream market data from websocket feed.
  """

  @callback handle_msg(msg :: String.t) :: nil

  defmacro __using__(_) do
    quote location: :keep do
      use WebSockex

      @behaviour ExGdax.Websocket

      @url "wss://ws-feed.gdax.com"

      @doc """
      Connects to websocket and subscribes to product feed.

      ## Parameters

      Name          | Default     | Description
      :------------ | :---------- | :----------
      `product_ids` | ["BTC-USD"] | GDAX products to receive messages for.
      `channels`    | ["full"]    | Channel - `full`, `heartbeat`, `ticker`, `level2`, `user`, or `matches`.
      """
      def start_link(product_ids \\ ["BTC-USD"], channels \\ ["full"], state \\ nil) do
        @url
        |> WebSockex.start_link(__MODULE__, state)
        |> init_subscriptions(product_ids, channels)
      end

      defp init_subscriptions({:ok, pid}, product_ids, channels) do
        subscribe(pid, product_ids, channels)
      end
      defp init_subscriptions({:error, reason}, _, _) do
        {:error, reason}
      end

      def subscribe(pid, product_ids, channels) do
        WebSockex.send_frame(pid, {:text, Poison.encode!(%{
          type: "subscribe",
          product_ids: product_ids,
          channels: channels
        })})
      end

      def handle_frame({:text, msg}, state) do
        handle_msg(msg)
        {:ok, state}
      end
    end
  end
end
