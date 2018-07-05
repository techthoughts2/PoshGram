# PoshGram

[![PowerShell Gallery][psgallery-img]][psgallery-site]
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-6.1-blue.svg)](https://github.com/PowerShell/PowerShell)

[psgallery-img]:   https://img.shields.io/powershellgallery/dt/PoshGram.svg
[psgallery-site]:  https://www.powershellgallery.com/packages/PoshGram
[psgallery-v1]:    https://www.powershellgallery.com/packages/PoshGram/0.8.1

## Synopsis

PoshGram is a PowerShell module that enables you to send messages via the Telegram Bot API

![PoshGram Gif Demo](media/PoshGram.gif "PoshGram in action")

## Description

PoshGram provides functionality to send various message types to a specified Telegram chat via the Telegram Bot API. Seperate PowerShell functions are used for each message type. Checks are included to ensure that file extensions, and file size restrictions are adhered to based on Telegram requirements.

PoshGram provides the following functions:

* [Test-BotToken](https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md)
* [Send-TelegramTextMessage](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md)
* [Send-TelegramLocalPhoto](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md)
* [Send-TelegramURLPhoto](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md)
* [Send-TelegramLocalDocument](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalDocument.md)
* [Send-TelegramURLDocument](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md)
* [Send-TelegramLocalVideo](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md)
* [Send-TelegramURLVideo](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLVideo.md)
* [Send-TelegramLocalAudio](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md)
* [Send-TelegramURLAudio](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLAudio.md)

## Why

The Telegram Bot API requires very specific formatting criteria for Bot messaging. The goal of this project to abstract that complexity away in favor of simple and direct PowerShell functions.

PoshGram also opens up several programmatic use cases:

* Custom scripts tied to task scheduler could alert you to potential system conditions
  * *Test-LowDisk.ps1 tied to task scheduler --> leverages PoshGram to alert you if low disk condition found*
* Enable script to provide Telegram notifications
* In a ForEach you could easily message multipe chat groups that your bot is a member of

## Installation

### Prerequisites

* [PowerShell 6.1.0](https://github.com/PowerShell/PowerShell)
* [Telegram Bot created](https://core.telegram.org/bots)
* Chat ID number
* Bot must be a member of the specified chat

### Installing PoshGram via PowerShell Gallery

```powershell
#from an administrative 6.1.0+ PowerShell session
Install-Module -Name "PoshGram"
```

### Installing PoshGram direct from GitHub

1. Create the following directory: ```C:\Program Files\WindowsPowerShell\Modules\PoshGram```
2. Download Zip from GitHub
3. Extract files
4. Copy the extracted files into the created directory

## Quick start

```powershell
#import the PoshGram module
Import-Module -Name "PoshGram"
#--------------------------------------------------------------------------
#easy way to validate your Bot token is functional
Test-BotToken -BotToken $botToken
#--------------------------------------------------------------------------
#send a basic Text Message
Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"
#--------------------------------------------------------------------------
#send a photo message from a local source
Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chat -PhotoPath $photo
#--------------------------------------------------------------------------
#send a photo message from a URL source
Send-TelegramURLPhoto -BotToken $botToken -ChatID $chat -PhotoURL $photoURL
#--------------------------------------------------------------------------
#send a file message from a local source
Send-TelegramLocalDocument -BotToken $botToken -ChatID $chat -File $file
#--------------------------------------------------------------------------
#send a file message from a URL source
Send-TelegramURLDocument -BotToken $botToken -ChatID $chat -FileURL $fileURL
#--------------------------------------------------------------------------
#send a video message from a local source
Send-TelegramLocalVideo -BotToken $botToken -ChatID $chat -Video $video
#--------------------------------------------------------------------------
#send a video message from a URL source
Send-TelegramURLVideo -BotToken $botToken -ChatID $chat -VideoURL $videoURL
#--------------------------------------------------------------------------
#send an audio message from a URL source
Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio
#--------------------------------------------------------------------------
#send an audio message from a local source
Send-TelegramURLAudio -BotToken $botToken -ChatID $chat -AudioURL $audioURL
#--------------------------------------------------------------------------
```

## Author

[Jake Morrison](https://twitter.com/JakeMorrison) - http://techthoughts.info

## Contributors

[Justin Saylor](https://twitter.com/XJustinSaylorX) - Logo

## Notes

* *Why is PowerShell 6.1.0 required? - Why can't I use 5.1?*
  * For new files to be uploaded and sent to a chat via bot, Telegram requires the use of multipart/form-data. This is not natively supported in 5.1. It is available in 6.0.0, but requires the manual creation of the form. 6.1.0 introduces native form capabilties. Functions that reference a URL, or that only use messenging (**Send-TelegramTextMessage**) are 5.1 compatible. However, you would have to pull these functions out seperately if you are absolutely set on using 5.1

* *I don't want to use PowerShell 6.1.0 because I primarily use 5.1 or lower*
  * Good news - PowerShell 6.1.0 installs to a completely seperate folder, has a completely different exe (pwsh.exe), and references a different module path. This means you can install it on any system and use PoshGram while continuing to use any other version of PowerShell

* *I want to start using this, but how do I create a Telegram Bot and get a token?*
  * To learn how to create and set up a bot:
    * [Introduction to Bots](https://core.telegram.org/bots)
    * [Bot FAQ](https://core.telegram.org/bots/faq)
    * [BotFather](https://t.me/BotFather)

* *I've got a bot setup, and I have a token, but how do I determine my channel ID?*
  * Forward a message from your channel to the getidsbot https://telegram.me/getidsbot
  * Use the Telegram web client and copy the channel ID in your browser's address bar
    * *Don't forget to include the (-) before the channel number*
      * Ex ```"-#########"```

* *Are there any restrictions when using PoshGram?*
  * Bots can currently send files of up to 50 MB in size
  * Certain functions are limited to certain file extensions, see each function's documentation for more information

For a description of the Bot API, see this page: https://core.telegram.org/bots/api