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

    test "reads api_key from PDFSHIFT_API_KEY environment variable" do
      System.put_env("PDFSHIFT_API_KEY", "env_api_key")

      try do
        config = Config.new()
        assert config.api_key == "env_api_key"
      after
        System.delete_env("PDFSHIFT_API_KEY")
      end
    end

    test "explicit api_key option takes precedence over environment variable" do
      System.put_env("PDFSHIFT_API_KEY", "env_api_key")

      try do
        config = Config.new(api_key: "explicit_key")
        assert config.api_key == "explicit_key"
      after
        System.delete_env("PDFSHIFT_API_KEY")
      end
    end
  end
end
