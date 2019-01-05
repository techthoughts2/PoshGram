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

PoshGram provides functionality to send various message types to a specified Telegram chat via the Telegram Bot API. Separate PowerShell functions are used for each message type. Checks are included to ensure that file extensions, and file size restrictions are adhered to based on Telegram requirements.

[PoshGram](https://github.com/techthoughts2/PoshGram/blob/master/docs/PoshGram.md) provides the following functions:

* [Send-TelegramLocalAnimation](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAnimation.md)
* [Send-TelegramLocalAudio](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md)
* [Send-TelegramLocalDocument](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalDocument.md)
* [Send-TelegramLocalPhoto](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md)
* [Send-TelegramLocalVideo](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md)
* [Send-TelegramLocation](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocation.md)
* [Send-TelegramMediaGroup](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramMediaGroup.md)
* [Send-TelegramTextMessage](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md)
* [Send-TelegramURLAnimation](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLAnimation.md)
* [Send-TelegramURLAudio](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLAudio.md)
* [Send-TelegramURLDocument](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md)
* [Send-TelegramURLPhoto](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md)
* [Send-TelegramURLVideo](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLVideo.md)
* [Test-BotToken](https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md)

## Why

The Telegram Bot API requires very specific formatting and criteria for Bot messaging. The goal of this project to abstract that complexity away in favor of simple and direct PowerShell commands.

PoshGram also opens up several programmatic use cases:

* Load PoshGram into Azure functions to alert you of potential conditions
* Load PoshGram into AWS Lambda to alert you of potential conditions
* Custom scripts tied to task scheduler could alert you to potential system conditions
  * *Test-LowDisk.ps1 tied to task scheduler --> leverages PoshGram to alert you if low disk condition found*
* Enable a script to provide Telegram notifications
* In a ForEach you could easily message multiple chat groups that your bot is a member of

## Installation

### Prerequisites

* [PowerShell 6.1.0](https://github.com/PowerShell/PowerShell)
* [Telegram Bot created](https://core.telegram.org/bots)
* Chat ID number
* Bot must be a member of the specified chat

### Installing PoshGram via PowerShell Gallery

***This is the recommended method***

```powershell
#from an administrative 6.1.0+ PowerShell session
Install-Module -Name "PoshGram"
```

### Installing PoshGram direct from GitHub

*Note: You will need to **build** PoshGram yourself using [Invoke-Build](https://github.com/nightroman/Invoke-Build) if you want to install directly from GitHub*

1. Download Zip from GitHub
2. Extract files
3. Navigate to download location
4. Change dir to **\src**
5. Invoke build
    ``` powershell
    Invoke-Build -Task Clean,CreateHelp,Build
    ```
6. Build will now be available in **\src\Artifacts**
7. Import PoshGram
    * Create the following directory: ```C:\Program Files\WindowsPowerShell\Modules\PoshGram```
      * Copy Artifact files into the created directory
    * Alternatively you can import module from Artifacts location manually

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
#send an audio message from a URL source
Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio
#------------------------------------------------------------------------------------------------
#send an audio message from a local source
Send-TelegramURLAudio -BotToken $botToken -ChatID $chat -AudioURL $audioURL
#------------------------------------------------------------------------------------------------
Send-TelegramLocation -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude
#------------------------------------------------------------------------------------------------
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chat -AnimationPath $animation
#------------------------------------------------------------------------------------------------
Send-TelegramURLAnimation -BotToken $botToken -ChatID $chat -AnimationURL $AnimationURL
#------------------------------------------------------------------------------------------------
Send-TelegramMediaGroup -BotToken $botToken -ChatID $chat -FilePaths (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)
#------------------------------------------------------------------------------------------------
###########################################################################
#sending a telegram message from older versions of powershell
###########################################################################
#here is an example of calling PowerShell 6.1 from PowerShell 5.1 to send a Telegram message with PoshGram
& 'C:\Program Files\PowerShell\6-preview\pwsh.exe' -command { Import-Module PoshGram;$token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx";$chat = "-#########";Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 6.1 to send Telegram Message via PoshGram" }
#--------------------------------------------------------------------------
#here is an example of calling PowerShell 6.1 from PowerShell 5.1 to send a Telegram message with PoshGram using dynamic variables in the message
$token = “#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx”
$chat = “-#########”
$test = "I am a test"
& '.\Program Files\PowerShell\6-preview\pwsh.exe' -command "& {Import-Module PoshGram;Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message '$test';}"
#--------------------------------------------------------------------------
```

## Author

[Jake Morrison](https://twitter.com/JakeMorrison) - [http://techthoughts.info/](http://techthoughts.info/)

## Contributors

[Justin Saylor](https://twitter.com/XJustinSaylorX) - Logo

[Mark Kraus](https://twitter.com/markekraus) - PowerShell 6.1 Form handling advice

[Andrew Pearce](https://twitter.com/austoonz) - CI/CD advice

## Notes

* [PoshGram Video Demo](https://youtu.be/OfyRVl7YThw)
* [PoshGram Blog Write-up](http://techthoughts.info/poshgram-powershell-module-for-telegram/)

* *Why is PowerShell 6.1.0 required? - Why can't I use 5.1?*
  * For new files to be uploaded and sent to a chat via bot, Telegram requires the use of multipart/form-data. This is not natively supported in 5.1. It is available in 6.0.0, but requires the manual creation of the form. 6.1.0 introduces native form capabilities. Functions that reference a URL, or that only use messaging  (**Send-TelegramTextMessage**) are 5.1 compatible. However, you would have to pull these functions out separately if you are absolutely set on using 5.1

* *I don't want to use PowerShell 6.1.0 because I primarily use 5.1 or lower*
  * Good news - PowerShell 6.1.0 installs to a completely separate folder, has a completely different exe (pwsh.exe), and references a different module path. This means you can install it on any system and use PoshGram while continuing to use any other version of PowerShell
  * Here is an example of how you can call PS 6.1 and use PoshGram from older versions of PowerShell:

    ```powershell
    #here is an example of calling PowerShell 6.1 from PowerShell 5.1 to send a Telegram message with PoshGram
    & 'C:\Program Files\PowerShell\6-preview\pwsh.exe' -command { Import-Module PoshGram;$token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx";$chat = "-#########";Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 6.1 to send Telegram Message via PoshGram" }
    ```

* *I want to start using this, but how do I create a Telegram Bot and get a token?*
  * To learn how to create and set up a bot:
    * [TechThoughts video on how to make a Telgram Bot](https://youtu.be/UhZtrhV7t3U)
    * [Introduction to Bots](https://core.telegram.org/bots)
    * [Bot FAQ](https://core.telegram.org/bots/faq)
    * [BotFather](https://t.me/BotFather)

* *I've got a bot setup, and I have a token, but how do I determine my channel ID?*
  * Forward a message from your channel to the getidsbot [https://telegram.me/getidsbot](https://telegram.me/getidsbot)
  * Use the Telegram web client and copy the channel ID in your browser's address bar
    * *Don't forget to include the (-) before the channel number*
      * Ex ```"-#########"```

* *Are there any restrictions when using PoshGram?*
  * Bots can currently send files of up to 50 MB in size
  * Certain functions are limited to certain file extensions, see each function's documentation for more information

For a description of the Bot API, see this page: [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)