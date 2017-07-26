defmodule ExGdax.Api do
  @moduledoc """
  Provides basic HTTP interface with GDAX API.
  """
  @url "https://api.gdax.com"
  @headers ["Content-Type": "application/json"]

  def get(endpoint, params \\ %{}) do
    endpoint
    |> url()
    |> HTTPoison.get(@headers, [params: params])
    |> parse_response()
  end

  defp url(endpoint), do: @url <> endpoint

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
