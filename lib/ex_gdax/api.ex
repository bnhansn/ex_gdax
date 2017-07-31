defmodule ExGdax.Api do
  @moduledoc """
  Provides basic HTTP interface with GDAX API.
  """
  @url "https://api.gdax.com"

  def get(path, params \\ %{}) do
    path
    |> url()
    |> HTTPoison.get(headers("GET", path), [params: params])
    |> parse_response()
  end

  def post(path, params \\ %{}) do
    path
    |> url()
    |> HTTPoison.post(params, headers("POST", path, params))
    |> parse_response()
  end

  def delete(path) do
    path
    |> url()
    |> HTTPoison.delete(headers("DELETE", path))
    |> parse_response()
  end

  defp url(path), do: @url <> path

  defp headers(method, path, body \\ %{}) do
    timestamp = :os.system_time(:seconds)
    [
      "Content-Type": "application/json",
      "CB-ACCESS-KEY": Application.get_env(:ex_gdax, :api_key),
      "CB-ACCESS-SIGN": sign_request(timestamp, method, path, body),
      "CB-ACCESS-TIMESTAMP": timestamp,
      "CB-ACCESS-PASSPHRASE": Application.get_env(:ex_gdax, :api_passphrase)
    ]
  end

  defp sign_request(timestamp, method, path, body) do
    key = Base.decode64!(Application.get_env(:ex_gdax, :api_secret))
    body = if Enum.empty?(body), do: "", else: Poison.encode!(body)
    data = "#{timestamp}#{method}#{path}#{body}"
    :sha256 |> :crypto.hmac(key, data) |> Base.encode64()
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
