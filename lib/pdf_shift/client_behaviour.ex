defmodule PDFShift.ClientBehaviour do
  @moduledoc """
  Behaviour specification for PDFShift API client.
  """

  @callback get(config :: PDFShift.Config.t(), endpoint :: String.t(), client_opts :: keyword()) ::
              {:ok, map()} | {:error, any()}
  @callback post(
              config :: PDFShift.Config.t(),
              endpoint :: String.t(),
              payload :: map(),
              client_opts :: keyword()
            ) ::
              {:ok, map()} | {:error, any()}
end
