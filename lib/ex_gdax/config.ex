defmodule ExGdax.Config do
  @moduledoc """
  Stores configuration variables for signing authenticated requests to GDAX.
  """
  @default_api_url "https://api.gdax.com"
  @enforce_keys [:api_key, :api_secret, :api_passphrase]
  defstruct [:api_key, :api_secret, :api_passphrase, api_url: @default_api_url]

  def config_or_env_config(nil) do
    %__MODULE__{
      api_key: api_key(),
      api_secret: api_secret(),
      api_passphrase: api_passphrase(),
      api_url: api_url()
    }
  end
  def config_or_env_config(config), do: config

  def api_key, do: from_env(:ex_gdax, :api_key)

  def api_secret, do: from_env(:ex_gdax, :api_secret)

  def api_passphrase, do: from_env(:ex_gdax, :api_passphrase)

  def api_url, do: from_env(:ex_gdax, :api_url, @default_api_url)

  defp from_env(otp_app, key, default \\ nil)
  defp from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, value}, default), do: value || default
  defp read_from_system(value, _default), do: value
end
