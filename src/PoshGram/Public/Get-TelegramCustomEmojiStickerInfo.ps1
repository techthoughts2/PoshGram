<#
.SYNOPSIS
    Retrieve information about Telegram custom emoji stickers using their identifiers.
.DESCRIPTION
    This function interacts with the Telegram Bot API to gather detailed information about custom emoji stickers
    specified by their unique identifiers. It can handle requests for up to 200 custom emoji IDs at a time
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    Get-TelegramCustomEmojiStickerInfo -BotToken $botToken -CustomEmojiIdentifier 5404870433939922908

    Retrieves detailed information about the custom emoji sticker with identifier 5404870433939922908.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    Get-TelegramCustomEmojiStickerInfo -BotToken $botToken -CustomEmojiIdentifier 5404870433939922908, 5368324170671202286

    Fetches information for multiple custom emoji stickers, using their respective identifiers 5404870433939922908 and 5368324170671202286.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER CustomEmojiIdentifier
    Custom emoji ID number(s). Specify up to 200 custom emoji IDs.
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

    Note:
        - This function is currently experimental. Bots can only access custom emoji sticker information for purchased additional usernames on Fragment.
            - This makes it difficult to determine the custom emoji ID for a custom emoji sticker pack.
        - pwshEmojiExplorer is used to retrieve additional emoji information.
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameter           Type                Required    Description
    custom_emoji_ids    Array of String     Yes         List of custom emoji identifiers. At most 200 custom emoji identifiers can be specified.
.LINK
    https://poshgram.readthedocs.io/en/latest/Get-TelegramCustomEmojiStickerInfo
.LINK
    https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/
.LINK
    https://core.telegram.org/bots/api#getcustomemojistickers
.LINK
    https://core.telegram.org/bots/api#sticker
.LINK
    https://core.telegram.org/bots/api
#>
function Get-TelegramCustomEmojiStickerInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = 'Custom Emoji pack name')]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(1, 200)]
        [string[]]$CustomEmojiIdentifier
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Debug -Message ('Identifier count: {0}' -f $CustomEmojiIdentifier.Count)

    $identifierList = New-Object System.Collections.Generic.List[string]
    foreach ($identifier in $CustomEmojiIdentifier) {
        [void]$identifierList.Add($identifier)
    }

    if ($identifierList.Count -eq 1) {
        # special case for single identifier where we have to hand-craft the JSON
        $jsonIdentifierArray = @"
[
    "$identifierList"
]
"@
    } #if
    else {
        $jsonIdentifierArray = $identifierList | ConvertTo-Json
    } #else

    $form = @{
        custom_emoji_ids = $jsonIdentifierArray
    } #form

    $uri = 'https://api.telegram.org/bot{0}/getCustomEmojiStickers' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Retrieving sticker information...'
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
        Write-Warning -Message 'An error was encountered getting the Telegram custom emoji pack info:'
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
            return $results
        }
        else {
            throw $_
        }
    } #catch_messageSend

    # Add-EmojiDetails

    Write-Verbose -Message 'Custom emoji information found. Processing emoji information...'
    $stickerData = New-Object System.Collections.Generic.List[Object]
    foreach ($emoji in $results.result) {
        #-------------------
        $enrichedEmoji = $null
        #-------------------
        $enrichedEmoji = Add-EmojiDetail -StickerObject $emoji
        [void]$stickerData.Add($enrichedEmoji)
    }

    return $stickerData
} #function_Get-TelegramCustomEmojiStickerInfo
