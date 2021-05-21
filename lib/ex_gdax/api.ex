defmodule ExGdax.Api do
  @moduledoc """
  Provides basic HTTP interface with GDAX API.
  """
  alias ExGdax.{Config, Auth}

  def get(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)
    qs = query_string(path, params)

    qs
    |> url(config)
    |> HTTPoison.get(headers("GET", qs, %{}, config))
    |> parse_response()
  end

  def post(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.post(Poison.encode!(params), headers("POST", path, params, config))
    |> parse_response()
  end

  def delete(path, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.delete(headers("DELETE", path, %{}, config))
    |> parse_response()
  end

  defp url(path, config), do: config.api_url <> path

  defp query_string(path, params) when map_size(params) == 0, do: path

  defp query_string(path, params) do
    query =
      params
      |> Enum.map(fn {key, val} -> "#{key}=#{val}" end)
      |> Enum.join("&")

    path <> "?" <> query
  end

  defp headers(method, path, body, config) do
    timestamp = :os.system_time(:seconds)

    [
      "Content-Type": "application/json",
      "CB-ACCESS-KEY": config.api_key,
      "CB-ACCESS-SIGN": Auth.sign_request(timestamp, method, path, body, config),
      "CB-ACCESS-TIMESTAMP": timestamp,
      "CB-ACCESS-PASSPHRASE": config.api_passphrase
    ]
  end

  defp parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: code}} ->
        if code in 200..299 do
          {:ok, Poison.decode!(body)}
        else
          case Poison.decode(body) do
            {:ok, json} -> {:error, json["message"], code}
            {:error, _} -> {:error, body, code}
          end
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
