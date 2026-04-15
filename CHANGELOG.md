# Changelog

All notable changes to this project will be documented in this file. See [Keep
a CHANGELOG](http://keepachangelog.com/) for how to update this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.2.1](https://github.com/sgerrand/ex_pdf_shift/compare/v0.2.0...v0.2.1) (2026-04-15)


### Bug Fixes

* eliminate retry wait times in tests ([#46](https://github.com/sgerrand/ex_pdf_shift/issues/46)) ([2083b43](https://github.com/sgerrand/ex_pdf_shift/commit/2083b43660db74845a04d8aaa60bb0391b3048c8))

## [0.2.0](https://github.com/sgerrand/ex_pdf_shift/compare/v0.1.0...v0.2.0) (2026-04-14)


### Bug Fixes

* correct zoom option typespec to number() ([#35](https://github.com/sgerrand/ex_pdf_shift/issues/35)) ([b3b6a1e](https://github.com/sgerrand/ex_pdf_shift/commit/b3b6a1e64d4780fb30c596623fbfe6a464dc98ac))
* return error from Config.new/1 when api_key is missing ([#42](https://github.com/sgerrand/ex_pdf_shift/issues/42)) ([412d685](https://github.com/sgerrand/ex_pdf_shift/commit/412d685ae1b54078fca909856d54e758b8b7fe59))
* use safe_transient retry strategy instead of infinite retry ([#37](https://github.com/sgerrand/ex_pdf_shift/issues/37)) ([2bf03fa](https://github.com/sgerrand/ex_pdf_shift/commit/2bf03faed829c74b0b3f0aa7f9472bd9d5b67e19))


### Code Refactoring

* make get_api_key_from_env/0 private ([#40](https://github.com/sgerrand/ex_pdf_shift/issues/40)) ([a6b61d8](https://github.com/sgerrand/ex_pdf_shift/commit/a6b61d8dd8a6db52d2230a019e5f6abb52c1cc30))

## [0.1.0](https://github.com/sgerrand/ex_pdf_shift/releases/tag/v0.1.0) (2025-04-08)

Initial release.
