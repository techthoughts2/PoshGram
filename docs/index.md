# PoshGram

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-6.1+-blue.svg)](https://github.com/PowerShell/PowerShell) [![PowerShell Gallery][psgallery-img]][psgallery-site] ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE) [![Documentation Status](https://readthedocs.org/projects/poshgram/badge/?version=latest)](https://poshgram.readthedocs.io/en/latest/?badge=latest)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/PoshGram.svg
[psgallery-site]:  https://www.powershellgallery.com/packages/PoshGram
[psgallery-v1]:    https://www.powershellgallery.com/packages/PoshGram
[license-badge]:   https://img.shields.io/github/license/techthoughts2/PoshGram

## What is PoshGram?

PoshGram is a PowerShell module that enables you to send messages via the Telegram Bot API through simple and intuitive commands. It's designed for ease and flexibility, enabling both simple and complex messaging capabilities directly from PowerShell. With PoshGram, users can send text messages, utilize rich formatting options, and incorporate diverse elements like custom keyboards, a variety of media types, stickers, and emojis.

## Why PoshGram?

PoshGram simplifies your interaction with the Telegram API. The Telegram Bot API has very specific formatting rules and criteria which can be complex to handle, especially regarding file types, sizes, and message formats. PoshGram automates these aspects, freeing you to concentrate on your core tasks rather than the complexities of the API.

Practical Use Cases:

- **Serverless Feedback**: Integrate PoshGram in Azure functions or AWS Lambda for condition-based alerts.
- **System Monitoring**: Utilize PoshGram with task schedulers for automated system health alerts, such as disk space monitoring.
- **Script Notifications**: Enhance scripts to send instant notifications on Telegram, improving the feedback loop for routine tasks.
- **Group Messaging**: Efficiently send messages to multiple chat groups, useful for broad communication needs.

PoshGram is designed to make Telegram communication via PowerShell a seamless part of your workflow, offering a practical solution to leverage Telegram's messaging capabilities in various automation scenarios.

## Getting Started

### Prerequisites

- [PowerShell](https://github.com/PowerShell/PowerShell) 6.1.0 (or higher version)
- Telegram requirements
    - A Telegram Account
    - [Telegram Bot created](https://core.telegram.org/bots#how-do-i-create-a-bot)
    - Chat ID number
    - Bot must be a member of the specified chat

*Note: See the [PoshGram - FAQ](PoshGram-FAQ.md) for more info on how to get some of these prerequisites.*

### Installation

```powershell
Install-Module -Name 'PoshGram' -Repository PSGallery -Scope CurrentUser
```

### Quick Start

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
Send-TelegramURLAnimation -BotToken $botToken -ChatID $chatID -AnimationURL $AnimationURL
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
Send-TelegramURLSticker -BotToken $botToken -ChatID $chatID -StickerURL $StickerURL
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
& '.\Program Files\PowerShell\6\pwsh.exe' -command "& {Import-Module PoshGram;Send-TelegramTextMessage -BotToken $token -ChatID $chatID -Message '$test';}"
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 7+ from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\7\pwsh.exe' -command { Import-Module PoshGram;$botToken = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chatID = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message "Test from 5.1 calling 7+ to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
```

## How PoshGram Works

PoshGram provides a set of PowerShell cmdlets specifically designed for interacting with the Telegram Bot API. These cmdlets enable a range of functions, from sending various types of messages and media to interacting with stickers and conducting polls. The module adheres to the Telegram API's file size and format limitations, alerting you if any adjustments are needed.

To begin using PoshGram, ensure your bot token is set up and the bot is added to the desired chat channel. After installing the module, you can immediately start using these capabilities in your PowerShell environment.

## Features

- **Versatile Messaging**: Send a wide variety of message types, including text, contact, dice, animation, audio, document, photo, sticker, video, location, multi-media, poll, and venue messages. It also supports HTML and Markdown for rich text formatting.
- **Interactive Elements**: Incorporate custom keyboards and inline buttons to make your messages interactive.
Sticker Info**: Easily query sticker packs, get sticker information, and send stickers directly through PowerShell commands.
- **Notification Control**: Opt to send messages silently or with notifications.
- **Content Protection**: Enable features to protect messages from being forwarded or saved.
- **Flexible Application**: Use in various scenarios like integrating with task schedulers, alert systems, serverless functions, or automating chat responses.
- **User-Friendly Experience**: PoshGram is designed for easy use, suitable for PowerShell users at various skill levels. It offers a simpler way to leverage Telegram's messaging features, combining straightforward cmdlets with clear documentation, ideal for enhancing PowerShell tasks with Telegram's capabilities.
