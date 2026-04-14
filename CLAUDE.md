# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About

`ex_pdf_shift` is an Elixir client library (hex package: `pdf_shift`) for the [PDFShift API](https://pdfshift.io), which converts HTML/URLs to PDF. It is a standalone library — not a Phoenix application.

## Commands

- Install dependencies: `mix deps.get`
- Run all tests: `mix test`
- Run a single test file: `mix test test/pdf_shift/client_test.exs`
- Run a single test: `mix test test/pdf_shift/client_test.exs:42`
- Lint: `mix credo`
- Format: `mix format`
- Generate docs: `mix docs`

## Architecture

The library is a thin HTTP wrapper with clean layering:

```text
PDFShift (public API)
  └─> PDFShift.API (endpoint definitions)
        └─> PDFShift.Client (HTTP via Req)
```

- **`PDFShift`** — public interface; `convert/3` and `credits_usage/1`. Loads the client module from `Application.get_env(:pdf_shift, :client_module, PDFShift.Client)` to allow test injection.
- **`PDFShift.API`** — maps functions to PDFShift v3 endpoints (`/convert/pdf`, `/credits/usage`).
- **`PDFShift.Client`** — implements `PDFShift.ClientBehaviour`; uses `Req` with HTTP Basic Auth (`api:<key>`), JSON encoding, and configurable timeouts (30s GET, 60s POST).
- **`PDFShift.Config`** — builds config struct from keyword opts or `PDFSHIFT_API_KEY` env var.
- **`PDFShift.Types`** — typespecs for all conversion options and response shapes.

## Testing

Tests use **Mox** for unit tests (via `PDFShift.MockClient`) and **Bypass** for HTTP-level integration tests. Test setup in `test/test_helper.exs` configures the app to use `MockClient` and enables `test_mode` (disables Req retries).

- `test/support/helper.ex` — shared fixtures: `test_config/0`, `sample_pdf_binary/0`, `success_convert_response/0`, etc.
- `test/support/mocks.ex` — defines `PDFShift.MockClient` via `Mox.defmock/2`.

## Code Style

- Add `@moduledoc` / `@doc` and typespecs to all public functions.
- Update typespecs when editing function signatures.
- Handle errors with pattern matching and `{:ok, _}` / `{:error, _}` tuples.
