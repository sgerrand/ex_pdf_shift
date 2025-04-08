ExUnit.start()

# Configure environment for tests
Application.put_env(:pdf_shift, :client_module, PDFShift.MockClient)
Application.put_env(:pdf_shift, :test_mode, true)
