# PoshGram

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-6.1+-blue.svg)](https://github.com/PowerShell/PowerShell) [![PowerShell Gallery][psgallery-img]][psgallery-site] ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE) [![Documentation Status](https://readthedocs.org/projects/poshgram/badge/?version=latest)](https://poshgram.readthedocs.io/en/latest/?badge=latest)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/PoshGram.svg
[psgallery-site]:  https://www.powershellgallery.com/packages/PoshGram
[psgallery-v1]:    https://www.powershellgallery.com/packages/PoshGram
[license-badge]:   https://img.shields.io/github/license/techthoughts2/PoshGram

<p align="left">
    <img src="docs/assets/PoshGram.png" alt="PoshGram Logo" >
</p>

Branch | Windows | MacOS | Linux
--- | --- | --- | --- |
main | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoibTI1bm9iZ0tRY3hGRzVUQzdKUzhyT0lGOUlCZHVySldHRCtyQlRRcVVKM0M4bExOMDgvdkMzdTR3MC83VGhzQzVBUVJ6ajFwNDFvVDUwQU5wK3BMNHUwPSIsIml2UGFyYW1ldGVyU3BlYyI6ImluRWp6VDA4eWYxNitqQ2giLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main) | [![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/f0l0iiqfq6tua4l1/branch/main?svg=true)](https://ci.appveyor.com/project/techthoughts2/poshgram/branch/main) | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiZHFxQmNXamdSTVJzd2FUcTUraWRDalAwRlNBRWNGV2MzVExZRHdKb2VwbGdtUHdJME91c05tVzYyWXJWMythSWR0dkROYTJkdWxGZG1sUWVuTTB0WWI4PSIsIml2UGFyYW1ldGVyU3BlYyI6IjhReWlJdmNZQSt3bW9Mb3MiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main) |
Enhancements | ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiRDRkc01KRlpFb3NFckRCRk14bFF3cGFpa3I5M3pNTHF5YXk2b2hrcFNEbU56bGlNVEovUzBLQ0xQcDlXa1oyaGVOZzN6WE0rZlNiM2dXR1U1eWpVWitzPSIsIml2UGFyYW1ldGVyU3BlYyI6IjAvTXY3R1YwWXFYQzg3TWoiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=Enhancements) | [![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/f0l0iiqfq6tua4l1/branch/Enhancements?svg=true)](https://ci.appveyor.com/project/techthoughts2/poshgram/branch/Enhancements)| ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiWmVlOTRZTGtPbjdKR3p5YjFTeGpuVmROZjJ0Unh1aVprYlErOG1CQ3ZKSVRaUEhxOW01OFdOQkRlRG0zb1JCNWI1aVJqcno0TG5FVnoxSnNrVnZvU21ZPSIsIml2UGFyYW1ldGVyU3BlYyI6IjFJalRUNFR5YTljUWFKUHEiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=Enhancements) |

## Synopsis

PoshGram is a PowerShell module that enables you to send messages via the Telegram Bot API

## Description

PoshGram provides functionality to send various message types to a specified Telegram chat via the Telegram Bot API. Separate PowerShell functions are used for each message type. Checks are included to ensure that file extensions, and file size restrictions are adhered to based on Telegram requirements.

## Features

- **Versatile Messaging**: Send a wide variety of message types, including text, contact, dice, animation, audio, document, photo, sticker, video, location, multi-media, poll, and venue messages. It also supports HTML and Markdown for rich text formatting.
- **Interactive Elements**: Incorporate custom keyboards and inline buttons to make your messages interactive.
Sticker Info**: Easily query sticker packs, get sticker information, and send stickers directly through PowerShell commands.
- **Notification Control**: Opt to send messages silently or with notifications.
- **Content Protection**: Enable features to protect messages from being forwarded or saved.
- **Flexible Application**: Use in various scenarios like integrating with task schedulers, alert systems, serverless functions, or automating chat responses.
- **User-Friendly Experience**: PoshGram is designed for easy use, suitable for PowerShell users at various skill levels. It offers a simpler way to leverage Telegram's messaging features, combining straightforward cmdlets with clear documentation, ideal for enhancing PowerShell tasks with Telegram's capabilities.

## Getting Started

### Documentation

Documentation for PoshGram is available at: [https://poshgram.readthedocs.io](https://poshgram.readthedocs.io)

### Prerequisites

- [PowerShell](https://github.com/PowerShell/PowerShell) 6.1.0 (or higher version)
- Telegram requirements
    - A Telegram Account
    - [Telegram Bot created](https://core.telegram.org/bots#how-do-i-create-a-bot)
    - Chat ID number
    - Bot must be a member of the specified chat

### Installation

```powershell
# from a 6.1.0+ PowerShell session
Install-Module -Name 'PoshGram' -Repository PSGallery -Scope CurrentUser
```

## Quick start

![PoshGram Gif Demo](docs/assets/PoshGram.gif "PoshGram in action")

```powershell
#------------------------------------------------------------------------------------------------
# import the PoshGram module
Import-Module -Name 'PoshGram'

# set your bot token and chat channel id
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
#------------------------------------------------------------------------------------------------
# easy way to validate your Bot token is functional
Test-BotToken -BotToken $botToken
#------------------------------------------------------------------------------------------------
# send a basic Text Message
Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message 'Hello'
#------------------------------------------------------------------------------------------------
# get information for a Telegram sticker pack
Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName STPicard
#------------------------------------------------------------------------------------------------
# get information about Telegram custom emoji stickers using their identifiers (experimental)
Get-TelegramCustomEmojiStickerInfo -BotToken $botToken -CustomEmojiIdentifier 5404870433939922908
#------------------------------------------------------------------------------------------------
# send a contact's information
Send-TelegramContact -BotToken $botToken -ChatID $chatID -PhoneNumber $phone -FirstName $firstName
#------------------------------------------------------------------------------------------------
#send an animated emoji that will display a random value
Send-TelegramDice -BotToken $botToken -ChatID $chatID -Emoji $emoji
#------------------------------------------------------------------------------------------------
# send an animated gif from a local source
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chatID -AnimationPath $animation
#------------------------------------------------------------------------------------------------
# send an audio message from a local source
Send-TelegramLocalAudio -BotToken $botToken -ChatID $chatID -Audio $audio
#------------------------------------------------------------------------------------------------
# send a file message from a local source
Send-TelegramLocalDocument -BotToken $botToken -ChatID $chatID -File $file
#------------------------------------------------------------------------------------------------
# send a photo message from a local source
Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chatID -PhotoPath $photo
#------------------------------------------------------------------------------------------------
#sends Telegram sticker message from a local source
Send-TelegramLocalSticker -BotToken $botToken -ChatID $chatID -StickerPath $sticker
#------------------------------------------------------------------------------------------------
# send a video message from a local source
Send-TelegramLocalVideo -BotToken $botToken -ChatID $chatID -Video $video
#------------------------------------------------------------------------------------------------
# send a map point location using Latitude and Longitude
Send-TelegramLocation -BotToken $botToken -ChatID $chatID -Latitude $latitude -Longitude $longitude
#------------------------------------------------------------------------------------------------
# sends a group of photos or videos as an album from a local source
Send-TelegramMediaGroup -BotToken $botToken -ChatID $chatID -FilePaths (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)
#------------------------------------------------------------------------------------------------
# send a poll with a question and options
Send-TelegramPoll -BotToken $botToken -ChatID $chatID -Question $question -Options $opt
#------------------------------------------------------------------------------------------------
#send Telegram sticker with known sticker file_id
Send-TelegramSticker -BotToken $botToken -ChatID $chatID -FileID $sticker
#send Telegram sticker (best effort) with sticker pack name and emoji shortcode
Send-TelegramSticker -BotToken $botToken -ChatID $chatID -StickerSetName STPicard -Shortcode ':slightly_smiling_face:'
#------------------------------------------------------------------------------------------------
# send an animated gif from a URL source
Send-TelegramURLAnimation -BotToken $botToken -ChatID $chatID -AnimationURL $animationURL
#------------------------------------------------------------------------------------------------
# send an audio message from a URL source
Send-TelegramURLAudio -BotToken $botToken -ChatID $chatID -AudioURL $audioURL
#------------------------------------------------------------------------------------------------
# send a file message from a URL source
Send-TelegramURLDocument -BotToken $botToken -ChatID $chatID -FileURL $fileURL
#------------------------------------------------------------------------------------------------
# send a photo message from a URL source
Send-TelegramURLPhoto -BotToken $botToken -ChatID $chatID -PhotoURL $photoURL
#------------------------------------------------------------------------------------------------
#send a sticker message from a URL source
Send-TelegramURLSticker -BotToken $botToken -ChatID $chatID -StickerURL $stickerURL
#------------------------------------------------------------------------------------------------
# send a video message from a URL source
Send-TelegramURLVideo -BotToken $botToken -ChatID $chatID -VideoURL $videoURL
#------------------------------------------------------------------------------------------------
# send information about a venue
Send-TelegramVenue -BotToken $botToken -ChatID $chatID -Latitude $latitude -Longitude $longitude -Title $title -Address $address
#------------------------------------------------------------------------------------------------
###########################################################################
#sending a telegram message from older versions of powershell
###########################################################################
#here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\6\pwsh.exe' -command { Import-Module PoshGram;$botToken = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chatID = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message "Test from 5.1 calling 6.1+ to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram using dynamic variables in the message
$botToken = “#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx”
$chatID = “-#########”
$test = "I am a test"
& '.\Program Files\PowerShell\6\pwsh.exe' -command "& {Import-Module PoshGram;Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message '$test';}"
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 7+ from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\7\pwsh.exe' -command { Import-Module PoshGram;$botToken = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chatID = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message "Test from 5.1 calling 7+ to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
```

## Notes

This PowerShell project was created with [Catesta](https://github.com/techthoughts2/Catesta).

## Contributing

If you'd like to contribute to pwshEmojiExplorer, please see the [contribution guidelines](.github/CONTRIBUTING.md).

## License

This project is [licensed under the MIT License](LICENSE).
