defmodule PDFShift.Client do
  @moduledoc """
  HTTP client for PDFShift API.
  """

  @behaviour PDFShift.ClientBehaviour

  @doc """
  Performs a GET request to the PDFShift API.
  """
  @impl true
  @spec get(PDFShift.Config.t(), String.t(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(config, endpoint, client_opts \\ []) do
    url = "#{config.base_url}#{endpoint}"

    Req.get(url,
      auth: {:basic, "api:#{config.api_key}"},
      receive_timeout: Keyword.get(client_opts, :timeout, 30_000),
      retry: Keyword.get(client_opts, :retry, retry_options()),
      connect_options: [protocols: [:http1]],
      json: true
    )
    |> handle_response()
  end

  @doc """
  Performs a POST request to the PDFShift API.
  """
  @impl true
  @spec post(PDFShift.Config.t(), String.t(), map(), keyword()) :: {:ok, map()} | {:error, any()}
  def post(config, endpoint, payload, client_opts \\ []) do
    url = "#{config.base_url}#{endpoint}"

    Req.post(url,
      auth: {:basic, "api:#{config.api_key}"},
      json: payload,
      receive_timeout: Keyword.get(client_opts, :timeout, 60_000),
      retry: Keyword.get(client_opts, :retry, retry_options()),
      connect_options: [protocols: [:http1]]
    )
    |> handle_response()
  end

  defp retry_options do
    if Application.get_env(:pdf_shift, :test_mode) do
      # No retries in test mode to speed up tests
      false
    else
      fn _attempt, _error -> true end
    end
  end

  defp handle_response({:ok, %{status: status} = response}) when status in 200..299 do
    {:ok, response}
  end

  defp handle_response({:ok, %{status: _status, body: body}}) when is_map(body) do
    error_message = Map.get(body, "error", "Unknown error")
    {:error, error_message}
  end

  defp handle_response({:error, exception}) do
    {:error, exception}
  end
end
