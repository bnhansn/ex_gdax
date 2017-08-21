defmodule ExGdax.Api do
  @moduledoc """
  Provides basic HTTP interface with GDAX API.
  """
  alias ExGdax.Config

  def get(path, params \\ %{}) do
    path = build_query_path(path, params)

    path
    |> url()
    |> HTTPoison.get(headers("GET", path))
    |> parse_response()
  end

  def post(path, params \\ %{}) do
    path
    |> url()
    |> HTTPoison.post(Poison.encode!(params), headers("POST", path, params))
    |> parse_response()
  end

  def delete(path) do
    path
    |> url()
    |> HTTPoison.delete(headers("DELETE", path))
    |> parse_response()
  end

  defp url(path), do: Config.api_url() <> path

  defp build_query_path(path, params) do
    query =
      params
      |> Enum.map(fn({key, val}) -> "#{key}=#{val}" end)
      |> Enum.join("&")

    String.trim_trailing(path <> "?" <> query, "?")
  end

  defp headers(method, path, body \\ %{}) do
    timestamp = :os.system_time(:seconds)

    [
      "Content-Type": "application/json",
      "CB-ACCESS-KEY": Config.api_key(),
      "CB-ACCESS-SIGN": sign_request(timestamp, method, path, body),
      "CB-ACCESS-TIMESTAMP": timestamp,
      "CB-ACCESS-PASSPHRASE": Config.api_passphrase(),
    ]
  end

  defp sign_request(timestamp, method, path, body) do
    key = Base.decode64!(Config.api_secret() || "")
    body = if Enum.empty?(body), do: "", else: Poison.encode!(body)
    data = "#{timestamp}#{method}#{path}#{body}"

    :sha256
    |> :crypto.hmac(key, data)
    |> Base.encode64()
  end

  defp parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: code}} ->
        if code in 200..299 do
          {:ok, Poison.decode!(body)}
        else
          {:error, Poison.decode!(body)["message"], code}
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
