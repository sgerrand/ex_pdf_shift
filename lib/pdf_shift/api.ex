defmodule PDFShift.API do
  @moduledoc """
  Module implementing the PDFShift API endpoints.
  """

  alias PDFShift.Config
  alias PDFShift.Types

  @doc """
  Converts a HTML document or URL to PDF.

  ## Parameters

    * `client` - The HTTP client module
    * `config` - The configuration struct
    * `source` - URL or HTML content to convert to PDF
    * `options` - Additional options for the conversion

  ## Returns

    * `{:ok, response}` - On successful conversion
    * `{:error, reason}` - On failure

  ## Examples

      iex> PDFShift.API.convert(PDFShift.Client, config, "https://example.com")
      {:ok, %{body: <<PDF binary data>>, status: 200, headers: [...]}}

  """
  @spec convert(module(), Config.t(), String.t(), Types.convert_options(), keyword()) ::
          {:ok, map()} | {:error, any()}
  def convert(client, config, source, options \\ %{}, client_opts \\ []) do
    payload = Map.put(options, :source, source)

    client.post(config, "/convert/pdf", payload, client_opts)
  end

  @doc """
  Gets the current credits usage.

  ## Parameters

    * `client` - The HTTP client module
    * `config` - The configuration struct

  ## Returns

    * `{:ok, response}` - On successful request
    * `{:error, reason}` - On failure

  ## Examples

      iex> PDFShift.API.credits_usage(PDFShift.Client, config)
      {:ok, %{
        body: %{
          "credits" => %{
            "base" => 50000,
            "remaining" => 49881,
            "total" => 50000,
            "used" => 119
          },
          "success" => true
        },
        status: 200,
        headers: [...]
      }}

  """
  @spec credits_usage(module(), Config.t(), keyword()) :: {:ok, map()} | {:error, any()}
  def credits_usage(client, config, client_opts \\ []) do
    client.get(config, "/credits/usage", client_opts)
  end
end
