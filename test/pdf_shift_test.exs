defmodule PDFShiftTest do
  use ExUnit.Case
  import Mox

  alias PDFShift.MockClient
  alias PDFShift.Test.Helper

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  # Make the expected client module return our mock
  setup do
    # Stub the client_module function to return our mock
    stub_with(PDFShift.MockClient, PDFShift.Client)
    :ok
  end

  describe "convert/3" do
    test "converts URL to PDF" do
      response = Helper.success_convert_response()

      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == "https://example.com"
        {:ok, response}
      end)

      assert {:ok, ^response} = PDFShift.convert("https://example.com")
    end

    test "converts URL to PDF with options" do
      response = Helper.success_convert_response()

      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == "https://example.com"
        assert payload.landscape == true
        assert payload.format == "A4"
        {:ok, response}
      end)

      assert {:ok, ^response} =
               PDFShift.convert(
                 "https://example.com",
                 %{landscape: true, format: "A4"}
               )
    end

    test "converts HTML to PDF" do
      html = "<html><body>Hello world</body></html>"
      response = Helper.success_convert_response()

      MockClient
      |> expect(:post, fn _config, "/convert/pdf", payload, _opts ->
        assert payload.source == html
        {:ok, response}
      end)

      assert {:ok, ^response} = PDFShift.convert(html)
    end

    test "uses api_key from options" do
      response = Helper.success_convert_response()

      MockClient
      |> expect(:post, fn config, "/convert/pdf", _payload, _opts ->
        assert config.api_key == "custom_api_key"
        {:ok, response}
      end)

      assert {:ok, ^response} =
               PDFShift.convert(
                 "https://example.com",
                 %{},
                 api_key: "custom_api_key"
               )
    end

    test "handles errors" do
      MockClient
      |> expect(:post, fn _config, "/convert/pdf", _payload, _opts ->
        {:error, "API error"}
      end)

      assert {:error, "API error"} = PDFShift.convert("https://example.com")
    end
  end

  describe "credits_usage/1" do
    test "gets credit usage information" do
      response = Helper.success_credits_response()

      MockClient
      |> expect(:get, fn _config, "/credits/usage", _opts ->
        {:ok, response}
      end)

      assert {:ok, ^response} = PDFShift.credits_usage()
    end

    test "uses api_key from options" do
      response = Helper.success_credits_response()

      MockClient
      |> expect(:get, fn config, "/credits/usage", _opts ->
        assert config.api_key == "custom_api_key"
        {:ok, response}
      end)

      assert {:ok, ^response} = PDFShift.credits_usage(api_key: "custom_api_key")
    end

    test "handles errors" do
      MockClient
      |> expect(:get, fn _config, "/credits/usage", _opts ->
        {:error, "API error"}
      end)

      assert {:error, "API error"} = PDFShift.credits_usage()
    end
  end
end
