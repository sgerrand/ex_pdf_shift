defmodule PDFShift.Types do
  @moduledoc """
  Type definitions for the PDFShift API.
  """

  @typedoc """
  Margin settings for the generated PDF.
  """
  @type margin :: %{
          optional(:top) => String.t(),
          optional(:right) => String.t(),
          optional(:bottom) => String.t(),
          optional(:left) => String.t()
        }

  @typedoc """
  Authentication settings for password-protected content.
  """
  @type auth :: %{
          required(:username) => String.t(),
          required(:password) => String.t()
        }

  @typedoc """
  Cookie settings for requests when loading the source.
  """
  @type cookie :: %{
          required(:name) => String.t(),
          required(:value) => String.t(),
          optional(:secure) => boolean(),
          optional(:http_only) => boolean()
        }

  @typedoc """
  HTTP headers for requests when loading the source.
  """
  @type http_headers :: %{String.t() => String.t()}

  @typedoc """
  Header settings for the generated PDF.
  """
  @type header :: %{
          required(:source) => String.t(),
          optional(:height) => String.t()
        }

  @typedoc """
  Footer settings for the generated PDF.
  """
  @type footer :: %{
          required(:source) => String.t(),
          optional(:height) => String.t()
        }

  @typedoc """
  Protection settings for the generated PDF.
  """
  @type protection :: %{
          required(:owner_password) => String.t(),
          required(:user_password) => String.t(),
          optional(:author) => String.t(),
          optional(:no_copy) => boolean(),
          optional(:no_modify) => boolean(),
          optional(:no_print) => boolean()
        }

  @typedoc """
  Watermark settings for the generated PDF.
  """
  @type watermark :: %{
          optional(:image) => String.t(),
          optional(:text) => String.t(),
          optional(:font_size) => integer(),
          optional(:font_family) => String.t(),
          optional(:font_color) => String.t(),
          optional(:font_opacity) => integer(),
          optional(:font_bold) => boolean(),
          optional(:font_italic) => boolean(),
          optional(:rotate) => integer()
        }

  @typedoc """
  Request options for converting HTML/URL to PDF.
  """
  @type convert_options :: %{
          optional(:sandbox) => boolean(),
          optional(:encode) => boolean(),
          optional(:filename) => String.t(),
          optional(:webhook) => String.t(),
          optional(:s3_destination) => String.t(),
          optional(:timeout) => integer(),
          optional(:wait_for) => String.t(),
          optional(:landscape) => boolean(),
          optional(:lazy_load_images) => boolean(),
          optional(:css) => String.t(),
          optional(:javascript) => String.t(),
          optional(:disable_javascript) => boolean(),
          optional(:disable_backgrounds) => boolean(),
          optional(:remove_blank) => boolean(),
          optional(:delay) => integer(),
          optional(:raise_for_status) => boolean(),
          optional(:use_print) => boolean(),
          optional(:format) => String.t(),
          optional(:pages) => String.t(),
          optional(:zoom) => integer(),
          optional(:is_gdpr) => boolean(),
          optional(:is_hipaa) => boolean(),
          optional(:margin) => margin(),
          optional(:auth) => auth(),
          optional(:cookies) => [cookie()],
          optional(:http_headers) => http_headers(),
          optional(:header) => header(),
          optional(:footer) => footer(),
          optional(:protection) => protection(),
          optional(:watermark) => watermark()
        }

  @typedoc """
  Credits usage response.
  """
  @type credits_response() :: %{
          :credits => %{
            :base => integer(),
            :remaining => integer(),
            :total => integer(),
            :used => integer()
          },
          :success => boolean()
        }

  @typedoc """
  Error response.
  """
  @type error_response() :: %{
          :success => boolean(),
          :error => String.t(),
          :errors => map(),
          :code => integer()
        }

  @typedoc """
  Response headers from the PDF conversion.
  """
  @type pdf_response_headers :: %{
          optional(:"x-pdfshift-processorx") => String.t(),
          optional(:"x-process-time") => integer(),
          optional(:"x-response-duration") => integer(),
          optional(:"x-response-status-code") => String.t(),
          optional(:"x-credits-used") => integer(),
          optional(:"x-credits-remaining") => String.t(),
          optional(:"x-request-id") => String.t()
        }
end
