<#
.SYNOPSIS
    Retrieve detailed information about a specified Telegram sticker pack.
.DESCRIPTION
    This function connects to the Telegram Bot API to fetch detailed information about a specified sticker pack.
    It is designed to help you explore the contents of a Telegram sticker pack by providing a variety of information for each sticker.
    This includes details like the associated emoji, its group and subgroup classifications, Unicode code, shortcode, and the sticker's file ID.
    It also leverages the capabilities of pwshEmojiExplorer to retrieve additional emoji information, enriching the data set provided.
    To effectively use this function, you need the name of the sticker pack. You can find this by sharing the sticker pack within the Telegram app, which will generate a link containing the pack's name.
    More information is available in the links.
.EXAMPLE
    Get-TelegramStickerPackInfo -BotToken $token -StickerSetName STPicard

    Retrieves information for the STPicard sticker pack from the Telegram Bot API.
.EXAMPLE
    Get-TelegramStickerPackInfo -BotToken $token -StickerSetName FriendlyFelines

    Retrieves information for the FriendlyFelines sticker pack from the Telegram Bot API.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER StickerSetName
    Name of the sticker set
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

    Note:
        - Some sticker authors use the same emoji for several of their stickers.
        - pwshEmojiExplorer is used to retrieve additional emoji information.
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameter               Type                    Required    Description
    name                    String                  Yes         Name of the sticker set
.LINK
    https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo
.LINK
    https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/
.LINK
    https://core.telegram.org/bots/api#getstickerset
.LINK
    https://core.telegram.org/bots/api#sticker
.LINK
    https://core.telegram.org/bots/api
#>
function Get-TelegramStickerPackInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = 'Sticker pack name')]
        [ValidateNotNullOrEmpty()]
        [string]$StickerSetName
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    $form = @{
        name = $StickerSetName
    } #form

    $uri = 'https://api.telegram.org/bot{0}/getStickerSet' -f $BotToken
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
        Write-Warning -Message 'An error was encountered getting the Telegram sticker info:'
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
            return $results
        }
        else {
            throw $_
        }
    } #catch_messageSend

    Write-Verbose -Message 'Sticker information found. Processing emoji information...'
    $stickerData = New-Object System.Collections.Generic.List[Object]
    foreach ($emoji in $results.result.stickers) {
        #-------------------
        $enrichedEmoji = $null
        #-------------------
        $enrichedEmoji = Add-EmojiDetail -StickerObject $emoji
        [void]$stickerData.Add($enrichedEmoji)
    }

    return $stickerData
} #function_Get-TelegramStickerPackInfo
