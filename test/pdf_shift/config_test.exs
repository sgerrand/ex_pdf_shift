defmodule PDFShift.ConfigTest do
  use ExUnit.Case, async: true

  alias PDFShift.Config

  describe "new/1" do
    test "creates a new config with defaults" do
      config = Config.new()
      assert config.base_url == "https://api.pdfshift.io/v3"
      assert config.api_key == nil
    end

    test "creates a new config with provided options" do
      config = Config.new(api_key: "test_api_key", base_url: "https://custom-api.example.com")
      assert config.base_url == "https://custom-api.example.com"
      assert config.api_key == "test_api_key"
    end
  end

  describe "get_api_key_from_env/0" do
    test "returns nil when environment variable is not set" do
      System.delete_env("PDFSHIFT_API_KEY")
      assert Config.get_api_key_from_env() == nil
    end

    test "returns the API key from environment variable" do
      System.put_env("PDFSHIFT_API_KEY", "env_api_key")
      assert Config.get_api_key_from_env() == "env_api_key"
      System.delete_env("PDFSHIFT_API_KEY")
    end
  end
end
