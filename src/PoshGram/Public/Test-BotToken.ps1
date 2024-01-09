<#
.SYNOPSIS
    Validates Bot auth Token
.DESCRIPTION
    A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    Test-BotToken -BotToken $botToken

    Validates the specified Bot auth token via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $testBotTokenSplat = @{
        BotToken = $botToken
        Verbose  = $true
    }
    Test-BotToken @testBotTokenSplat

    Validates the specified Bot auth token via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
.LINK
    https://poshgram.readthedocs.io/en/latest/Test-BotToken
.LINK
    https://core.telegram.org/bots/api#getme
.LINK
    https://core.telegram.org/bots/api
#>
function Test-BotToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    $uri = 'https://api.telegram.org/bot{0}/getMe' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Testing Bot Token...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        ErrorAction = 'Stop'
        Method      = 'Get'
    }
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered testing the BOT token:'
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Test-BotToken
