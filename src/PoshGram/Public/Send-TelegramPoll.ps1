<#
.Synopsis
    Sends Telegram native poll.
.DESCRIPTION
    Uses Telegram Bot API to send a native poll with a question and several answer options.
.EXAMPLE
    $botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    $question = 'What is your favorite Star Trek series?'
    $opt = @(
        'Star Trek: The Original Series',
        'Star Trek: The Animated Series',
        'Star Trek: The Next Generation',
        'Star Trek: Deep Space Nine',
        'Star Trek: Voyager',
        'Star Trek: Enterprise',
        'Star Trek: Discovery',
        'Star Trek: Picard'
    )
    Send-TelegramPoll -BotToken $botToken -ChatID $chat -Question $question -Options $opt

    Sends poll via Telegram API
.EXAMPLE
    $botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    $question = 'Who is your favorite Star Fleet Captain?'
    $opt = 'Jean-Luc Picard','Jean-Luc Picard','Jean-Luc Picard'
    Send-TelegramPoll `
        -BotToken $token `
        -ChatID $chat `
        -Question $question `
        -Options $opt `
        -DisableNotification

    Sends poll via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Question
    Poll question
.PARAMETER Options
    String array of answer options
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Telegram currently supports questions 1-255 characters
    Telegram currently supports 2-10 options 1-100 characters each
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    question                String                  Yes         Poll question, 1-255 characters
    options                 Array of String         Yes         List of answer options, 2-10 strings 1-100 characters each
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md
.LINK
    https://core.telegram.org/bots/api#sendpoll
#>
function Send-TelegramPoll {
    [CmdletBinding()]
    Param
    (
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
            HelpMessage = 'Poll question')]
        [ValidateLength(1, 255)]
        [string]$Question,
        [Parameter(Mandatory = $true,
            HelpMessage = 'String array of answer options')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Options,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $optionEval = Test-PollOptions -PollOptions $Options
    if ($optionEval -eq $false) {
        $results = $false
        return $results
    }
    #------------------------------------------------------------------------
    $Options = $Options | ConvertTo-Json
    $uri = "https://api.telegram.org/bot$BotToken/sendPoll"
    $Form = @{
        chat_id              = $ChatID
        question             = $Question
        disable_notification = $DisableNotification.IsPresent
        options              = $Options
    }#form
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = $Uri
        ErrorAction = 'Stop'
        Form        = $Form
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram poll:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramPoll