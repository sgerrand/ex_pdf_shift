defmodule PDFShiftTest do
  use ExUnit.Case, async: true

  import Mox, only: [expect: 3, verify_on_exit!: 1]

  alias PDFShift.MockClient
  alias PDFShift.Test.Helper

  setup :verify_on_exit!

  setup do
    success_convert_response = Helper.success_convert_response()
    success_credits_response = Helper.success_credits_response()

    [
      success_convert_response: success_convert_response,
      success_credits_response: success_credits_response
    ]
  end

  describe "convert/3" do
    test "converts URL to PDF", %{success_convert_response: response} do
      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == "https://example.com"
        {:ok, response}
      end)

      assert PDFShift.convert("https://example.com") == {:ok, response}
    end

    test "converts URL to PDF with options", %{success_convert_response: response} do
      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == "https://example.com"
        assert payload.landscape == true
        assert payload.format == "A4"
        {:ok, response}
      end)

      assert PDFShift.convert(
               "https://example.com",
               %{landscape: true, format: "A4"}
             ) == {:ok, response}
    end

    test "converts HTML to PDF", %{success_convert_response: response} do
      html = "<html><body>Hello world</body></html>"

      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == html
        {:ok, response}
      end)

      assert PDFShift.convert(html) == {:ok, response}
    end

    test "uses api_key from options", %{success_convert_response: response} do
      MockClient
      |> expect(:post, fn config, "/convert/pdf", _payload, _opts ->
        assert config.api_key == "custom_api_key"
        {:ok, response}
      end)

      assert PDFShift.convert(
               "https://example.com",
               %{},
               api_key: "custom_api_key"
             ) == {:ok, response}
    end

    test "handles errors" do
      MockClient
      |> expect(:post, fn _config, "/convert/pdf", _payload, _opts ->
        {:error, "API error"}
      end)

      assert PDFShift.convert("https://example.com") == {:error, "API error"}
    end
  end

  describe "credits_usage/1" do
    test "gets credit usage information", %{success_credits_response: response} do
      MockClient
      |> expect(:get, fn _config, "/credits/usage", _opts ->
        {:ok, response}
      end)

      assert PDFShift.credits_usage() == {:ok, response}
    end

    test "uses api_key from options", %{success_credits_response: response} do
      MockClient
      |> expect(:get, fn config, "/credits/usage", _opts ->
        assert config.api_key == "custom_api_key"
        {:ok, response}
      end)

      assert PDFShift.credits_usage(api_key: "custom_api_key") == {:ok, response}
    end

    test "handles errors" do
      MockClient
      |> expect(:get, fn _config, "/credits/usage", _opts ->
        {:error, "API error"}
      end)

      assert PDFShift.credits_usage() == {:error, "API error"}
    end
  end
end
