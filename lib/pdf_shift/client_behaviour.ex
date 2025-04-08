defmodule PDFShift.ClientBehaviour do
  @moduledoc """
  Behaviour specification for PDFShift API client.
  """

  @callback get(PDFShift.Config.t(), String.t(), keyword()) :: {:ok, map()} | {:error, any()}
  @callback post(PDFShift.Config.t(), String.t(), map(), keyword()) ::
              {:ok, map()} | {:error, any()}
end
