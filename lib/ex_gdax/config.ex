defmodule ExGdax.Config do
  @moduledoc """
  Stores configuration variables for signing authenticated requests to GDAX.
  """
  def api_key, do: from_env(:ex_gdax, :api_key)

  def api_secret, do: from_env(:ex_gdax, :api_secret)

  def api_passphrase, do: from_env(:ex_gdax, :api_passphrase)

  def api_url, do: from_env(:ex_gdax, :api_url, "https://api.gdax.com")

  defp from_env(otp_app, key, default \\ nil)
  defp from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, env}, default), do: System.get_env(env) || default
  defp read_from_system(value, _default), do: value
end
