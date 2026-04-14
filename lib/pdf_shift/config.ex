defmodule PDFShift.Config do
  @moduledoc """
  Configuration module for PDFShift API client.
  """

  @type t :: %__MODULE__{
          api_key: String.t(),
          base_url: String.t()
        }

  defstruct api_key: nil,
            base_url: "https://api.pdfshift.io/v3"

  @doc """
  Creates a new configuration with the given options.

  Returns `{:error, reason}` if no API key is available.

  ## Options

    * `:api_key` - API key for authentication with PDFShift
    * `:base_url` - Base URL for the PDFShift API (defaults to "https://api.pdfshift.io/v3")

  ## Examples

      iex> PDFShift.Config.new(api_key: "api_key123")
      {:ok, %PDFShift.Config{api_key: "api_key123", base_url: "https://api.pdfshift.io/v3"}}

      iex> PDFShift.Config.new()
      {:error, "API key is required. Pass api_key: \"...\" or set PDFSHIFT_API_KEY."}

  """
  @spec new(keyword()) :: {:ok, t()} | {:error, String.t()}
  def new(opts \\ []) do
    api_key = Keyword.get(opts, :api_key) || get_api_key_from_env()
    base_url = Keyword.get(opts, :base_url, "https://api.pdfshift.io/v3")

    if api_key do
      {:ok, %__MODULE__{api_key: api_key, base_url: base_url}}
    else
      {:error, "API key is required. Pass api_key: \"...\" or set PDFSHIFT_API_KEY."}
    end
  end

  defp get_api_key_from_env do
    System.get_env("PDFSHIFT_API_KEY")
  end
end
