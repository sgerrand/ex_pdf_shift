defmodule PDFShift.ClientTest do
  use ExUnit.Case, async: false

  import Mox, only: [verify_on_exit!: 1]

  alias PDFShift.Client

  setup :verify_on_exit!

  setup do
    bypass = Bypass.open()

    config = %PDFShift.Config{
      api_key: "test_api_key",
      base_url: "http://localhost:#{bypass.port}"
    }

    {:ok, bypass: bypass, config: config}
  end

  describe "get/3" do
    test "handles successful response", %{bypass: bypass, config: config} do
      Bypass.expect(bypass, "GET", "/test-endpoint", fn conn ->
        Plug.Conn.resp(conn, 200, Jason.encode!(%{success: true, data: "test"}))
      end)

      assert {:ok, %{status: 200, body: %{"success" => true, "data" => "test"}}} =
               Client.get(config, "/test-endpoint")
    end

    test "handles error response", %{bypass: bypass, config: config} do
      Bypass.expect(bypass, "GET", "/test-endpoint", fn conn ->
        Plug.Conn.resp(conn, 401, Jason.encode!(%{success: false, error: "Invalid API key"}))
      end)

      assert {:error, "Invalid API key"} = Client.get(config, "/test-endpoint")
    end

    test "handles network errors", %{config: config} do
      assert {:error, %Mint.TransportError{}} =
               Client.get(
                 %{config | base_url: "http://non-existent-domain:12345"},
                 "/test-endpoint"
               )
    end
  end

  describe "post/4" do
    test "handles successful response", %{bypass: bypass, config: config} do
      Bypass.expect(bypass, "POST", "/test-endpoint", fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(body) == %{"key" => "value"}

        Plug.Conn.resp(conn, 200, Jason.encode!(%{success: true, data: "test"}))
      end)

      assert {:ok, %{status: 200, body: %{"success" => true, "data" => "test"}}} =
               Client.post(config, "/test-endpoint", %{key: "value"})
    end

    test "handles error response", %{bypass: bypass, config: config} do
      Bypass.expect(bypass, "POST", "/test-endpoint", fn conn ->
        Plug.Conn.resp(conn, 401, Jason.encode!(%{success: false, error: "Invalid API key"}))
      end)

      assert {:error, "Invalid API key"} = Client.post(config, "/test-endpoint", %{})
    end

    test "handles network errors", %{config: config} do
      assert {:error, %Mint.TransportError{}} =
               Client.post(
                 %{config | base_url: "http://non-existent-domain:12345"},
                 "/test-endpoint",
                 %{}
               )
    end
  end
end
