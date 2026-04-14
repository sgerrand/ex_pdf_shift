defmodule PDFShift.ConfigTest do
  use ExUnit.Case, async: true

  alias PDFShift.Config

  describe "new/1" do
    test "returns error when no api_key is available" do
      System.delete_env("PDFSHIFT_API_KEY")
      assert {:error, reason} = Config.new()
      assert reason =~ "API key is required"
    end

    test "creates a new config with provided api_key" do
      assert {:ok, config} =
               Config.new(api_key: "test_api_key", base_url: "https://custom-api.example.com")

      assert config.base_url == "https://custom-api.example.com"
      assert config.api_key == "test_api_key"
    end

    test "uses default base_url when not provided" do
      assert {:ok, config} = Config.new(api_key: "test_api_key")
      assert config.base_url == "https://api.pdfshift.io/v3"
    end

    test "reads api_key from PDFSHIFT_API_KEY environment variable" do
      System.put_env("PDFSHIFT_API_KEY", "env_api_key")

      try do
        assert {:ok, config} = Config.new()
        assert config.api_key == "env_api_key"
      after
        System.delete_env("PDFSHIFT_API_KEY")
      end
    end

    test "explicit api_key option takes precedence over environment variable" do
      System.put_env("PDFSHIFT_API_KEY", "env_api_key")

      try do
        assert {:ok, config} = Config.new(api_key: "explicit_key")
        assert config.api_key == "explicit_key"
      after
        System.delete_env("PDFSHIFT_API_KEY")
      end
    end
  end
end
