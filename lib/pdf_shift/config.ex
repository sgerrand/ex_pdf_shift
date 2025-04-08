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

  ## Options

    * `:api_key` - API key for authentication with PDFShift
    * `:base_url` - Base URL for the PDFShift API (defaults to "https://api.pdfshift.io/v3")

  ## Examples

      iex> PDFShift.Config.new(api_key: "api_key123")
      %PDFShift.Config{api_key: "api_key123", base_url: "https://api.pdfshift.io/v3"}

  """
  @spec new(keyword()) :: t()
  def new(opts \\ []) do
    api_key = Keyword.get(opts, :api_key) || get_api_key_from_env()
    base_url = Keyword.get(opts, :base_url, "https://api.pdfshift.io/v3")

    %__MODULE__{
      api_key: api_key,
      base_url: base_url
    }
  end

  @doc """
  Gets the API key from environment variables.
  """
  @spec get_api_key_from_env() :: String.t() | nil
  def get_api_key_from_env do
    System.get_env("PDFSHIFT_API_KEY")
  end
end
