defmodule ExGdax.Auth do
  def sign_request(timestamp, method, path, body, config) do
    key = Base.decode64!(config.api_secret || "")
    body = if Enum.empty?(body), do: "", else: Poison.encode!(body)
    data = "#{timestamp}#{method}#{path}#{body}"

    :hmac
    |> :crypto.mac(:sha256, key, data)
    |> Base.encode64()
  end
end
