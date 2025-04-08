defmodule PDFShift do
  @moduledoc """
  PDFShift API client for Elixir.

  This module provides a simple interface to interact with the PDFShift API for:
  - Converting HTML or URLs to PDF
  - Checking credit usage

  ## Authentication

  The client uses HTTP Basic Authentication with your PDFShift API key.
  Set the API key using one of these methods:

  1. Set the `PDFSHIFT_API_KEY` environment variable
  2. Pass the API key in the options to each function
     ```elixir
     PDFShift.convert("https://example.com", %{}, api_key: "your_api_key")
     ```

  ## Examples

  Converting a URL to PDF:
  ```elixir
  PDFShift.convert("https://example.com")
  ```

  Converting HTML content to PDF:
  ```elixir
  PDFShift.convert("<html><body>Hello World</body></html>")
  ```

  Converting with additional options:
  ```elixir
  PDFShift.convert("https://example.com", %{
    landscape: true,
    format: "A4"
  })
  ```

  Checking credit usage:
  ```elixir
  PDFShift.credits()
  ```
  """

  alias PDFShift.API
  alias PDFShift.Config
  alias PDFShift.Types

  @doc """
  Converts HTML content or a URL to a PDF document.

  ## Parameters

    * `source` - URL or HTML content to convert to PDF
    * `options` - Additional options for the conversion (see "Options" below)
    * `config_opts` - Configuration options for the client (`:api_key`, `:base_url`)

  ## Options

  #{for {key, desc} <- [sandbox: "Will generate documents that don't count towards your credits. The generated document will come with a watermark.", encode: "Will return the generated PDF in Base64 encoded format, instead of raw.", filename: "Name of the destination file. If given, the response will be a JSON with a URL to download the file.", webhook: "An URL where PDFShift will send a POST request with the conversion result.", s3_destination: "Path to your S3 bucket to save the converted PDF directly into your AWS S3 account.", timeout: "Will kill the page loading at a specified time without stopping with a TimeoutError (in seconds).", wait_for: "Name of a function available globally. PDFShift will wait for this function to return a truthy value.", landscape: "Will set the view in landscape mode instead of portrait.", lazy_load_images: "Will load images that are otherwise only loaded when they are visible.", css: "Will append CSS styles to the document. Can be a URL or a String of CSS rules.", javascript: "Will execute the given Javascript before saving. Can be a URL or a String of JS code.", disable_javascript: "Will not execute any javascript in the document.", disable_backgrounds: "The final document will not have background images.", remove_blank: "Remove the last page if it is considered empty.", delay: "In milliseconds. Will wait for this duration before capturing the document (max 10 seconds).", raise_for_status: "Will stop the conversion if the status_code from the given source is not 2XX.", use_print: "Use the print stylesheet instead of the general one.", format: "Format of the document. Standard values (A4, Letter, etc.) or custom width x height.", pages: "Pages to print. Can be one number, a range, a list or a combination.", zoom: "A value between 0 and 2. Controls zoom level in the document.", is_gdpr: "If true, ensures data protection compliance by refusing certain features.", is_hipaa: "If true, ensures HIPAA compliance by refusing certain features.", margin: "Object defining empty spaces around the content (top, right, bottom, left).", auth: "Object containing username and password for accessing password-protected content.", cookies: "List of cookies to send along with the requests when loading the source.", http_headers: "List of HTTP headers to pass to the request.", header: "Object defining a custom header with source and height properties.", footer: "Object defining a custom footer with source and height properties.", protection: "Object defining PDF restrictions and passwords.", watermark: "Object defining a watermark to add to the document."],
  do: "  * `#{key}` - #{desc}"}

  ## Examples

      iex> PDFShift.convert("https://example.com")
      {:ok, %{body: <<PDF binary data>>, status: 200, headers: [...]}}

      iex> PDFShift.convert("<html><body>Hello world</body></html>", %{sandbox: true})
      {:ok, %{body: <<PDF binary data>>, status: 200, headers: [...]}}

  """
  @spec convert(String.t(), Types.convert_options(), keyword()) :: {:ok, map()} | {:error, any()}
  def convert(source, options \\ %{}, config_opts \\ []) do
    config = Config.new(config_opts)
    client = client_module()

    API.convert(client, config, source, options)
  end

  @doc """
  Get current credit usage information.

  ## Parameters

    * `config_opts` - Configuration options for the client (`:api_key`, `:base_url`)

  ## Examples

      iex> PDFShift.credits_usage()
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
  @spec credits_usage(keyword()) :: {:ok, map()} | {:error, any()}
  def credits_usage(config_opts \\ []) do
    config = Config.new(config_opts)
    client = client_module()

    API.credits_usage(client, config)
  end

  defp client_module do
    Application.get_env(:pdf_shift, :client_module, PDFShift.Client)
  end
end
