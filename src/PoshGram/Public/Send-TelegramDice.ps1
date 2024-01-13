<#
.SYNOPSIS
    Sends Telegram animated emoji that will display a random value.
.DESCRIPTION
    Uses Telegram Bot API to send animated emoji that will display a random value to specified Telegram chat.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $emoji = 'basketball'
    Send-TelegramDice -BotToken $botToken -ChatID $chatID -Emoji $emoji

    Sends animated basketball emoji that displays a random value via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $emoji = 'dice'
    $sendTelegramDiceSplat = @{
        BotToken            = $botToken
        ChatID              = $chatID
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
        Emoji               = $emoji
    }
    Send-TelegramDice @sendTelegramDiceSplat

    Sends animated dice emoji that displays a random value via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Emoji
    Emoji on which the dice throw animation is based.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    emoji                   String                  Optional    Emoji on which the dice throw animation is based. Currently, must be one of “🎲”, “🎯”, or “🏀”. Dice can have values 1-6 for “🎲” and “🎯”, and values 1-5 for “🏀”. Defaults to “🎲”
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramDice
.LINK
    https://core.telegram.org/bots/api#senddice
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramDice {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = 'Emoji on which the dice throw animation is based.')]
        [ValidateSet('dice', 'dart', 'basketball', 'football', 'slotmachine', 'bowling')]
        [string]$Emoji,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    switch ($Emoji) {
        dice {
            $emojiSend = '🎲'
        }
        dart {
            $emojiSend = '🎯'
        }
        basketball {
            $emojiSend = '🏀'
        }
        football {
            $emojiSend = '⚽'
        }
        slotmachine {
            $emojiSend = '🎰'
        }
        bowling {
            $emojiSend = '🎳'
        }
    }

    $form = @{
        chat_id              = $ChatID
        emoji                = $emojiSend
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendDice' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending dice...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        ErrorAction = 'Stop'
        Form        = $form
        Method      = 'Post'
    }
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram location:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramDice
