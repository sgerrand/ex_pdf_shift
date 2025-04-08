# PDFShift

[![Hex Version](https://img.shields.io/hexpm/v/pdf_shift.svg)](https://hex.pm/packages/pdf_shift)
[![Hex Docs](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/pdf_shift/)

An Elixir client for the [PDFShift API](https://pdfshift.io), which allows you to convert HTML to PDF.

## Installation

The package can be installed by adding `pdf_shift` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pdf_shift, "~> 0.1.0"}
  ]
end
```

## Configuration

You need a PDFShift API key to use this client. You can get one by signing up at [PDFShift](https://pdfshift.io).

Set your API key using one of these methods:

1. Set the `PDFSHIFT_API_KEY` environment variable
2. Pass the API key in the options to each function
   ```elixir
   PDFShift.convert("https://example.com", %{}, api_key: "your_api_key")
   ```

## Usage

### Converting a URL to PDF

```elixir
PDFShift.convert("https://example.com")
```

### Converting HTML content to PDF

```elixir
PDFShift.convert("<html><body>Hello World</body></html>")
```

### Converting with options

```elixir
PDFShift.convert("https://example.com", %{
  landscape: true,
  format: "A4",
  margin: %{
    top: "1cm",
    right: "1cm",
    bottom: "1cm",
    left: "1cm"
  },
  header: %{
    source: "<div style='text-align: center;'>Header</div>",
    height: "2cm"
  },
  footer: %{
    source: "<div style='text-align: center;'>Page {{page}} of {{total}}</div>",
    height: "2cm"
  }
})
```

### Check credit usage

```elixir
PDFShift.credits()
```

## Available options

The following options can be passed to the `convert/3` function:

- `sandbox` - Will generate documents that don't count towards your credits. The generated document will come with a watermark.
- `encode` - Will return the generated PDF in Base64 encoded format, instead of raw.
- `filename` - Name of the destination file. If given, the response will be a JSON with a URL to download the file.
- `webhook` - An URL where PDFShift will send a POST request with the conversion result.
- `s3_destination` - Path to your S3 bucket to save the converted PDF directly into your AWS S3 account.
- `timeout` - Will kill the page loading at a specified time without stopping with a TimeoutError (in seconds).
- `wait_for` - Name of a function available globally. PDFShift will wait for this function to return a truthy value.
- `landscape` - Will set the view in landscape mode instead of portrait.
- `lazy_load_images` - Will load images that are otherwise only loaded when they are visible.
- `css` - Will append CSS styles to the document. Can be a URL or a String of CSS rules.
- `javascript` - Will execute the given Javascript before saving. Can be a URL or a String of JS code.
- `disable_javascript` - Will not execute any javascript in the document.
- `disable_backgrounds` - The final document will not have background images.
- `remove_blank` - Remove the last page if it is considered empty.
- `delay` - In milliseconds. Will wait for this duration before capturing the document (max 10 seconds).
- `raise_for_status` - Will stop the conversion if the status_code from the given source is not 2XX.
- `use_print` - Use the print stylesheet instead of the general one.
- `format` - Format of the document. Standard values (A4, Letter, etc.) or custom width x height.
- `pages` - Pages to print. Can be one number, a range, a list or a combination.
- `zoom` - A value between 0 and 2. Controls zoom level in the document.
- `is_gdpr` - If true, ensures data protection compliance by refusing certain features.
- `is_hipaa` - If true, ensures HIPAA compliance by refusing certain features.
- `margin` - Object defining empty spaces around the content (top, right, bottom, left).
- `auth` - Object containing username and password for accessing password-protected content.
- `cookies` - List of cookies to send along with the requests when loading the source.
- `http_headers` - List of HTTP headers to pass to the request.
- `header` - Object defining a custom header with source and height properties.
- `footer` - Object defining a custom footer with source and height properties.
- `protection` - Object defining PDF restrictions and passwords.
- `watermark` - Object defining a watermark to add to the document.

## Development

After checking out the repo, run `mix deps.get` to install dependencies. Then, run `mix test` to run the tests.

## License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

