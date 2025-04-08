defmodule PDFShift.Test.Helper do
  @moduledoc false

  @doc """
  Creates a test configuration.
  """
  def test_config do
    PDFShift.Config.new(api_key: "test_api_key", base_url: "https://api.pdfshift.io/v3")
  end

  @doc """
  Creates a sample PDF binary for testing.
  """
  def sample_pdf_binary do
    <<37, 80, 68, 70, 45, 49, 46, 53, 10, 37, 226, 227, 207, 211, 10, 53, 32, 48, 32, 111, 98,
      106, 10, 60, 60, 47, 76, 101, 110, 103, 116, 104, 32, 54, 32, 48, 32, 82, 47, 70, 105, 108,
      116, 101, 114, 32, 47, 70, 108, 97, 116, 101, 68, 101, 99, 111, 100, 101, 62, 62, 10, 115,
      116, 114, 101, 97, 109>>
  end

  @doc """
  Creates a success response map for convert endpoint.
  """
  def success_convert_response do
    %{
      status: 200,
      body: sample_pdf_binary(),
      headers: [
        {"x-pdfshift-processor", "chrome"},
        {"x-process-time", "1234"},
        {"x-response-duration", "1000"},
        {"x-response-status-code", "200"},
        {"x-credits-used", "1"},
        {"x-credits-remaining", "49999"},
        {"x-request-id", "abc123"}
      ]
    }
  end

  @doc """
  Creates a success response map for credits endpoint.
  """
  def success_credits_response do
    %{
      status: 200,
      body: %{
        "credits" => %{
          "base" => 50000,
          "remaining" => 49881,
          "total" => 50000,
          "used" => 119
        },
        "success" => true
      },
      headers: []
    }
  end

  @doc """
  Creates an error response map.
  """
  def error_response(message \\ "Invalid API key", status \\ 401) do
    %{
      status: status,
      body: %{
        "success" => false,
        "error" => message,
        "code" => status
      },
      headers: []
    }
  end
end
