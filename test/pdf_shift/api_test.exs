defmodule PDFShift.APITest do
  use ExUnit.Case, async: true

  import Mox

  alias PDFShift.API
  alias PDFShift.MockClient
  alias PDFShift.Test.Helper

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "convert/4" do
    test "calls client.post with correct parameters" do
      config = Helper.test_config()
      response = Helper.success_convert_response()

      MockClient
      |> expect(:post, fn ^config, "/convert/pdf", payload, _opts ->
        assert payload.source == "https://example.com"
        assert payload.landscape == true
        assert payload.format == "A4"
        {:ok, response}
      end)

      assert {:ok, ^response} =
               API.convert(
                 MockClient,
                 config,
                 "https://example.com",
                 %{landscape: true, format: "A4"}
               )
    end

    test "returns error when client returns error" do
      config = Helper.test_config()

      MockClient
      |> expect(:post, fn ^config, "/convert/pdf", _payload, _opts ->
        {:error, "API error"}
      end)

      assert {:error, "API error"} =
               API.convert(
                 MockClient,
                 config,
                 "https://example.com"
               )
    end
  end

  describe "credits_usage/2" do
    test "calls client.get with correct parameters" do
      config = Helper.test_config()
      response = Helper.success_credits_response()

      MockClient
      |> expect(:get, fn ^config, "/credits/usage", _opts ->
        {:ok, response}
      end)

      assert {:ok, ^response} = API.credits_usage(MockClient, config)
    end

    test "returns error when client returns error" do
      config = Helper.test_config()

      MockClient
      |> expect(:get, fn ^config, "/credits/usage", _opts ->
        {:error, "API error"}
      end)

      assert {:error, "API error"} = API.credits_usage(MockClient, config)
    end
  end
end
