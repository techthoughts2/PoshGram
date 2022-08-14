# PoshGram Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.3.0]

- Added support for WEBM stickers
- Build/dev improvements
  - CodeBuild image updates:
    - ```aws/codebuild/windows-base:2019-1.0``` to ```aws/codebuild/windows-base:2019-2.0```
    - ```aws/codebuild/standard:5.0``` to  ```aws/codebuild/standard:6.0```
  - ```buildspec_windows.yml```
    - Updated to use .NET 6.0
  - ```buildspec_pwsh_linux.yml```
    - Updated to use .NET 6.0

## [2.2.2]

- Fixed ```Send-TelegramPoll``` bug where Quiz mode answer could not specify first option correctly.
- Minor spelling corrections throughout
- Build/dev improvements
  - Changed Pester configuration from static property to ```New-PesterConfiguration```
  - Updated VSCode tasks to no longer use legacy Pester parameters
  - Bumped module versions to latest available

## [2.2.0]

- Added Protected Content parameter:
  - ```Send-TelegramTextMessage```
  - ```Send-TelegramLocalPhoto```
  - ```Send-TelegramURLPhoto```
  - ```Send-TelegramLocalVideo```
  - ```Send-TelegramURLVideo```
  - ```Send-TelegramLocalAudio```
  - ```Send-TelegramURLAudio```
  - ```Send-TelegramLocalAnimation```
  - ```Send-TelegramURLAnimation```
  - ```Send-TelegramLocalDocument```
  - ```Send-TelegramURLDocument```
  - ```Send-TelegramSticker```
  - ```Send-TelegramLocalSticker```
  - ```Send-TelegramURLSticker```
  - ```Send-TelegramContact```
  - ```Send-TelegramDice```
  - ```Send-TelegramLocation```
  - ```Send-TelegramMediaGroup```
  - ```Send-TelegramPoll```
  - ```Send-TelegramVenue```
- Added better examples of how to use text formatting with HTML and MarkdownV2 styling
  - Also added a section to the FAQ covering this
- Build/dev improvements
  - Added support for using new main branch instead of master
  - Bumped module versions to latest available
  - ```buildspec_windows.yml```
    - Updated to use .NET 5.0 and native pwsh install. Removed manual pwsh install logic.
  - Build file
    - Raised code coverage requirement to 95
    - Updated unit test path reference to ```$script:UnitTestsPath```
  - Converted build resources from manual deployment to CloudFormation
- Updated README
  - Added License badge
  - Adjusted formatting

## [2.0.0]

- Adjusted error control and error return behavior - ***potential* breaking change**
  - Previous behavior: any error (API error, validation error [size requirements, extension verification, etc.] would return a Boolean value: ```$false```)
    - This behavior wasn't especially helpful and did not provide a lot of insight into what went wrong
    - This behavior did not allow you to take any meaningful action if the API endpoint returned a certain error condition
  - New behavior:
    - Any validation error with ```throw``` for the failed validation
    - Any API error will return as a PSObject containing the API exception
      - Example 1:

        ```powershell
        ok      error_code description
        --      ---------- -----------
        False          401 Unauthorized
        ```

      - Example 2:

        ```powershell
        ok      error_code description                       parameters
        --      ---------- -----------                       ----------
        False          429 Too Many Requests: retry after 10 @{retry_after=10}
        ```

- General code style adjustments throughout the code-base
- Build/dev improvements
  - Bumped module versions to latest available
  - Updated Pester tests from Pester 4 to Pester 5
  - Updated CodeBuild to use latest version of PowerShell 7
  - Added new functionality to ```tasks.json```
  - Updated infra tests to have API back off capability

## [1.16.0]

- String literals throughout PoshGram now use single quotes (') instead of double quotes (")
- ```Send-TelegramDice```
  - Now supports bowling emoji
- Added FileName parameter to:
  - ```Send-TelegramURLAudio```
  - ```Send-TelegramURLVideo```
  - ```Send-TelegramLocalAudio```
  - ```Send-TelegramLocalVideo```
- ***Added custom and inline keyboard support for ```Send-TelegramTextMessage```***
- Added more examples for ```Send-TelegramTextMessage``` help
- Added additional documentation enhancements for emoji support and keyboards to FAQ.md

## [1.15.0]

- ```Send-TelegramLocalAudio``` / ```Send-TelegramURLAudio```
  - Audio now supports both MP3 and M4A file extensions
- ```Send-TelegramDice```
  - Now supports soccer (football), and slot machine emoji
- ```Send-TelegramLocalDocument``` / ```Send-TelegramURLDocument```
  - Added DisableContentTypeDetection switch which disables automatic server-side content type detection
- ```Send-TelegramPoll```
  - Questions can now be 300 characters long
- ```Send-TelegramMediaGroup```
  - Now supports both audio and document media group types
  - Restructured logic of this cmdlet to engage a new private function: ```Test-MediaGroupRequirements```
- Added more verbosity in verbose and warning outputs
- Removed manifest release notes and linked changelog
- Build Improvements
  - Restructured private tests from one monolithic file to separate private function tests
  - Restructured test folder layout
  - Updated Windows CodeBuild container from 2016 to 2019

## [1.14.0]

- Added **```Send-TelegramDice```**
- Updated help for all cmdlets to include splat examples
- Updated help examples for ```Send-TelegramTextMessage``` to include properly formatted MarkdownV2 examples
- Updated ```Send-TelegramPoll```
  - Added newly supported parameters:
    - Explanation
    - ExplanationParseMode
    - OpenPeriod
    - CloseDate
  - New private function ```Test-Explanation``` created to validate provided Explanation
- Added help clarification to ```Get-TelegramStickerPackInfo``` for finding sticker pack name
- Several module build improvements made
  - Updated PowerShell module references to latest versions
  - Infra tests converted to use splat expressions
  - Updated CodeBuild image references
  - Updated CodeBuild to use latest version of PowerShell 7

## [03/10/2020]

No Version Change

- Build/dev improvements
  - Bumped module versions to latest available
  - Replaced monolithic AWSPowerShell module with new AWS.Tools versions
  - Switched Windows Build container to use PowerShell 7 instead of PowerShell 7 preview
  - Updated ```tasks.json``` to have better integration with InvokeBuild
  - Switched Infra tests to use new AWS.Tools module

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

- Fixed bug where DisableNotification had no effect when running ```Send-TelegramSticker```

## [1.10.0]

- Significantly improved formatting of help for all functions
- Added ```Send-TelegramURLSticker```
- Added ```Send-TelegramLocalSticker```
- Added ```Send-TelegramSticker```
- Added ```Get-TelegramStickerPackInfo```
- Added ```Send-TelegramPoll```
- Added ```Send-TelegramVenue```
- Added ```Send-TelegramContact```
- Unit Tests split into separate function files
- Build file
  - Separated Infrastructure tests into new task
  - Adjusted local test to not include infrastructure tests
- Added full parameter references to unit tests
- psd1 - Sorted functions and tags alphabetically
- Parameter adjustments
  - ```Send-TelegramLocalAnimation```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramLocalAudio```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramLocalDocument```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramLocalPhoto```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramLocalVideo```
    - DisableNotification changed from bool to switch
    - Streaming changed from bool to switch
  - ```Send-TelegramMediaGroup```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramTextMessage```
    - Preview parameter renamed to DisablePreview and changed from bool to switch
    - DisableNotification changed from bool to switch
  - ```Send-TelegramURLAnimation```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramURLAudio```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramURLDocument```
    - DisableNotification changed from bool to switch
  - ```Send-TelegramURLPhoto```
    - DisableNotification changed from bool to switch

## [10/13/2019]

No Version Change

- Updated ```.gitignore``` references
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

- Addressed bug in ```Send-TelegramTextMessage``` that was not handling underscores
- Added code to support AWS Codebuild

## [0.9.0]

- Restructured module for CI/CD Workflow
- Added Invoke-Build capabilities to module
- Added Animation functionality:
  - ```Send-TelegramLocalAnimation```
  - ```Send-TelegramURLAnimation```
- Added location functionality:
  - ```Send-TelegramLocation```
- Added multi-media functionality:
  - ```Send-TelegramMediaGroup```
- Consolidated private support functions
- Code Logic improvements

## [0.8.4]

- Added IconURI to manifest

## [0.8.3]

- 0.8.3 Initial beta release.
