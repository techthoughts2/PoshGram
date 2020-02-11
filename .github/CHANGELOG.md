# PoshGram Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [02/10/2020]

No Version Change

- Updated README
  - Removed FAQ from primary README
- Added PoshGram-FAQ.md
  - Added new section under FAQ addressing how to send inline emojis in messages.

## [1.12.0]

- Added support for MarkdownV2
- Changed default Parse Mode for all functions from legacy Markdown to HTML
- Added support for Polls v2.0 features

## [1.10.1]

- Fixed bug where DisableNotification had no effect when running Send-TelegramSticker

## [1.10.0]

- Significantly improved formatting of help for all functions
- Added Send-TelegramURLSticker
- Added Send-TelegramLocalSticker
- Added Send-TelegramSticker
- Added Get-TelegramStickerPackInfo
- Added Send-TelegramPoll
- Added Send-TelegramVenue
- Added Send-TelegramContact
- Unit Tests split into separate function files
- Build file
  - Separated Infrastructure tests into new task
  - Adjusted local test to not include infrastructure tests
- Added full parameter references to unit tests
- psd1 - Sorted functions and tags alphabetically
- Parameter adjustments
  - Send-TelegramLocalAnimation
    - DisableNotification changed from bool to switch
  - Send-TelegramLocalAudio
    - DisableNotification changed from bool to switch
  - Send-TelegramLocalDocument
    - DisableNotification changed from bool to switch
  - Send-TelegramLocalPhoto
    - DisableNotification changed from bool to switch
  - Send-TelegramLocalVideo
    - DisableNotification changed from bool to switch
    - Streaming changed from bool to switch
  - Send-TelegramMediaGroup
    - DisableNotification changed from bool to switch
  - Send-TelegramTextMessage
    - Preview parameter renamed to DisablePreview and changed from bool to switch
    - DisableNotification changed from bool to switch
  - Send-TelegramURLAnimation
    - DisableNotification changed from bool to switch
  - Send-TelegramURLAudio
    - DisableNotification changed from bool to switch
  - Send-TelegramURLDocument
    - DisableNotification changed from bool to switch
  - Send-TelegramURLPhoto
    - DisableNotification changed from bool to switch

## [10/13/2019]

No Version Change

- Updated gitignore references
- Updated README to reflect 6.1+ PowerShell version
- Updated vscode settings for Stroustrup code formatting
- Added Git community files
  - Code of conduct
  - Pull request template
  - bug report template
  - Changelog
  - Contributing guidelines
- Updated modules references in install_modules to latest versions

## [1.0.2]

- Addressed bug where certain UTF-8 characters would fail to send properly in Send-TelegramTextMessage
- Cosmetic code change for Invoke functions to use splat parameters

## [1.0.0]

- Addressed bug in Send-TelegramTextMessage that was not handling underscores
- Added code to support AWS Codebuild

## [0.9.0]

- Restructured module for CI/CD Workflow
- Added Invoke-Build capabilities to module
- Added Animation functionality:
  - Send-TelegramLocalAnimation
  - Send-TelegramURLAnimation
- Added location functionality:
  - Send-TelegramLocation
- Added multi-media functionality:
  - Send-TelegramMediaGroup
- Consolidated private support functions
- Code Logic improvements

## [0.8.4]

- Added IconURI to manifest

## [0.8.3]

- 0.8.3 Initial beta release.
