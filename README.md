# PoshGram

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-6.1+-blue.svg)](https://github.com/PowerShell/PowerShell) [![PowerShell Gallery][psgallery-img]][psgallery-site] ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/PoshGram.svg
[psgallery-site]:  https://www.powershellgallery.com/packages/PoshGram
[psgallery-v1]:    https://www.powershellgallery.com/packages/PoshGram
[license-badge]:   https://img.shields.io/github/license/techthoughts2/PoshGram

Branch | Windows | MacOS | Linux
--- | --- | --- | --- |
main | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiK2NkZ3hhMHpScFZocS9RME5rSDdkMUR0SHlTcXYrUHg4UHEzVE9HQ2czaHBDY2hVSTVraVpuRUFYdkNTUWhmNDN5eXd0Zzc5T3QwRlR0ZnhQbGpBOTBRPSIsIml2UGFyYW1ldGVyU3BlYyI6IlpBVmUvc3VtVWlhOUx4SVoiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main) | [![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/f0l0iiqfq6tua4l1/branch/main?svg=true)](https://ci.appveyor.com/project/techthoughts2/poshgram/branch/main) | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiNXZVVG9XUXhYUmZrSFk3dXI0RXlxSWNOY01pWlVYVEU5T3B2S2ZRQ2IvYjc1MUdoUUV1N1lYalZ4dWUyTTN4RldSb0t0NUFSc1IxaDZHT29DRlNzSzdFPSIsIml2UGFyYW1ldGVyU3BlYyI6ImlvemtJTDBjb3BmSVJkTG0iLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main) |
Enhancements | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiZFptMjNOYmk0SGQ0NW5GRE9pN1BPRS9INklCcmRzNnorZjEyQWZxVnJSSjU2djFRN2RST01yL0pvb1VMeXFIUDExVXNSWXgwa0pqcm10T0kyeEwyR1hrPSIsIml2UGFyYW1ldGVyU3BlYyI6ImxUUGh3SUw2RW51WWVrRWMiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=Enhancements) | [![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/f0l0iiqfq6tua4l1/branch/Enhancements?svg=true)](https://ci.appveyor.com/project/techthoughts2/poshgram/branch/Enhancements)| ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiZzNabUY5aFlQU05Hbzd5dnVrVWtaSkMyamZuYVRhNzB5dHJpQ3pNbDBwOG5HYWFFL082anBGVzZhRDYwaWhXbm5PK0lycldHYmE2bitwSTNwcWxpMEhVPSIsIml2UGFyYW1ldGVyU3BlYyI6Ik81V25ISzR1TCtybzFneTciLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=Enhancements) |

## Synopsis

PoshGram is a PowerShell module that enables you to send messages via the Telegram Bot API

![PoshGram Gif Demo](media/PoshGram.gif "PoshGram in action")

## Description

PoshGram provides functionality to send various message types to a specified Telegram chat via the Telegram Bot API. Separate PowerShell functions are used for each message type. Checks are included to ensure that file extensions, and file size restrictions are adhered to based on Telegram requirements.

[PoshGram](https://github.com/techthoughts2/PoshGram/blob/main/docs/PoshGram.md) provides the following functions:

* [Get-TelegramStickerPackInfo](https://github.com/techthoughts2/PoshGram/blob/main/docs/Get-TelegramStickerPackInfo.md)
* [Send-TelegramContact](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramContact.md)
* [Send-TelegramDice](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramDice.md)
* [Send-TelegramLocalAnimation](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalAnimation.md)
* [Send-TelegramLocalAudio](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalAudio.md)
* [Send-TelegramLocalDocument](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalDocument.md)
* [Send-TelegramLocalPhoto](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalPhoto.md)
* [Send-TelegramLocalSticker](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalSticker.md)
* [Send-TelegramLocalVideo](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocalVideo.md)
* [Send-TelegramLocation](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramLocation.md)
* [Send-TelegramMediaGroup](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramMediaGroup.md)
* [Send-TelegramPoll](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramPoll.md)
* [Send-TelegramSticker](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramSticker.md)
* [Send-TelegramTextMessage](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramTextMessage.md)
* [Send-TelegramURLAnimation](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLAnimation.md)
* [Send-TelegramURLAudio](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLAudio.md)
* [Send-TelegramURLDocument](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLDocument.md)
* [Send-TelegramURLPhoto](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLPhoto.md)
* [Send-TelegramURLSticker](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLSticker.md)
* [Send-TelegramURLVideo](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLVideo.md)
* [Send-TelegramVenue](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramVenue.md)
* [Test-BotToken](https://github.com/techthoughts2/PoshGram/blob/main/docs/Test-BotToken.md)

## Why

The Telegram Bot API requires very specific formatting and criteria for Bot messaging. The goal of this project is to abstract that complexity away in favor of simple and direct PowerShell commands.

PoshGram also opens up several programmatic use cases:

* Load PoshGram into Azure functions to alert you of potential conditions
* Load PoshGram into AWS Lambda to alert you of potential conditions
* Custom scripts tied to task scheduler could alert you to potential system conditions
  * *Test-LowDisk.ps1 tied to task scheduler --> leverages PoshGram to alert you if low disk condition found*
* Enable a script to provide Telegram notifications
* In a ForEach you could easily message multiple chat groups that your bot is a member of

## Installation

### Prerequisites

* [PowerShell 6.1.0](https://github.com/PowerShell/PowerShell) *(or higher version)*
* A Telegram Account
* [Telegram Bot created](https://core.telegram.org/bots)
* Chat ID number
* Bot must be a member of the specified chat

### Installing PoshGram via PowerShell Gallery

```powershell
#from a 6.1.0+ PowerShell session
Install-Module -Name "PoshGram" -Scope CurrentUser
```

## Quick start

```powershell
#------------------------------------------------------------------------------------------------
#import the PoshGram module
Import-Module -Name "PoshGram"
#------------------------------------------------------------------------------------------------
#easy way to validate your Bot token is functional
Test-BotToken -BotToken $botToken
#------------------------------------------------------------------------------------------------
#send a basic Text Message
Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"
#------------------------------------------------------------------------------------------------
#send a photo message from a local source
Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chat -PhotoPath $photo
#------------------------------------------------------------------------------------------------
#send a photo message from a URL source
Send-TelegramURLPhoto -BotToken $botToken -ChatID $chat -PhotoURL $photoURL
#------------------------------------------------------------------------------------------------
#send a file message from a local source
Send-TelegramLocalDocument -BotToken $botToken -ChatID $chat -File $file
#------------------------------------------------------------------------------------------------
#send a file message from a URL source
Send-TelegramURLDocument -BotToken $botToken -ChatID $chat -FileURL $fileURL
#------------------------------------------------------------------------------------------------
#send a video message from a local source
Send-TelegramLocalVideo -BotToken $botToken -ChatID $chat -Video $video
#------------------------------------------------------------------------------------------------
#send a video message from a URL source
Send-TelegramURLVideo -BotToken $botToken -ChatID $chat -VideoURL $videoURL
#------------------------------------------------------------------------------------------------
#send an audio message from a local source
Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio
#------------------------------------------------------------------------------------------------
#send an audio message from a URL source
Send-TelegramURLAudio -BotToken $botToken -ChatID $chat -AudioURL $audioURL
#------------------------------------------------------------------------------------------------
#send a map point location using Latitude and Longitude
Send-TelegramLocation -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude
#------------------------------------------------------------------------------------------------
#send an animated gif from a local source
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chat -AnimationPath $animation
#------------------------------------------------------------------------------------------------
#send an animated gif from a URL source
Send-TelegramURLAnimation -BotToken $botToken -ChatID $chat -AnimationURL $AnimationURL
#------------------------------------------------------------------------------------------------
#sends a group of photos or videos as an album from a local source
Send-TelegramMediaGroup -BotToken $botToken -ChatID $chat -FilePaths (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)
#------------------------------------------------------------------------------------------------
#send a contact's information
Send-TelegramContact -BotToken $botToken -ChatID $chat -PhoneNumber $phone -FirstName $firstName
#------------------------------------------------------------------------------------------------
#send information about a venue
Send-TelegramVenue -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude -Title $title -Address $address
#------------------------------------------------------------------------------------------------
#send a poll with a question and options
Send-TelegramPoll -BotToken $botToken -ChatID $chat -Question $question -Options $opt
#------------------------------------------------------------------------------------------------
#get information for a Telegram sticker pack
Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName STPicard
#------------------------------------------------------------------------------------------------
#sends Telegram sticker message from a local source
Send-TelegramLocalSticker -BotToken $botToken -ChatID $chat -StickerPath $sticker
#------------------------------------------------------------------------------------------------
#send Telegram sticker with known sticker file_id
Send-TelegramSticker -BotToken $botToken -ChatID $chat -FileID $sticker
#send Telegram sticker (best effort) with sticker pack name and emoji shortcode
Send-TelegramSticker -BotToken $botToken -ChatID $chat -StickerSetName STPicard -Shortcode ':slightly_smiling_face:'
#------------------------------------------------------------------------------------------------
#send a sticker message from a URL source
Send-TelegramURLSticker -BotToken $botToken -ChatID $chat -StickerURL $StickerURL
#------------------------------------------------------------------------------------------------
#send an animated emoji that will display a random value
Send-TelegramDice -BotToken $botToken -ChatID $chat -Emoji $emoji
#------------------------------------------------------------------------------------------------
###########################################################################
#sending a telegram message from older versions of powershell
###########################################################################
#here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\6\pwsh.exe' -command { Import-Module PoshGram;$token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chat = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 6.1+ to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram using dynamic variables in the message
$token = “#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx”
$chat = “-#########”
$test = "I am a test"
& '.\Program Files\PowerShell\6\pwsh.exe' -command "& {Import-Module PoshGram;Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message '$test';}"
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 7+ from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\7-preview\pwsh.exe' -command { Import-Module PoshGram;$token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chat = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 7+ to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
```

## FAQ

**[PoshGram - FAQ](docs/PoshGram-FAQ.md)**

## Author

[Jake Morrison](https://twitter.com/JakeMorrison) - [https://www.techthoughts.info/](https://www.techthoughts.info/)

## Contributors

* [Justin Saylor](https://twitter.com/XJustinSaylorX) - Logo
* [Mark Kraus](https://twitter.com/markekraus) - PowerShell 6.1 Form handling advice
* [Andrew Pearce](https://twitter.com/austoonz) - CI/CD advice

## Notes

* [PoshGram Video Demo](https://youtu.be/OfyRVl7YThw)
* [PoshGram Blog Write-up](https://www.techthoughts.info/poshgram-powershell-module-for-telegram/)

For a description of the Bot API, see this page: [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

This PowerShell project was created with [Catesta](https://github.com/techthoughts2/Catesta).

## License

This project is [licensed under the MIT License](LICENSE).

## Changelog

Reference the [Changelog](.github/CHANGELOG.md)
