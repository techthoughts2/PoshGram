<#
.Synopsis
    Get information for specified Telegram sticker pack.
.DESCRIPTION
    Uses Telegram Bot API to retrieve Telegram sticker pack information.
    Displays emoji,emoji code, emoji shortcode, bytes, and file_id, and file information for each sticker in the sticker pack.
    You will need the name of the sticker pack you want to retrieve information for.
    To find the name of a sticker pack use the telegram app to share the sticker pack. This will provide a link which contains the sticker pack name.
    More information is available in the links.
.EXAMPLE
    Get-TelegramStickerPackInfo -BotToken $token -StickerSetName STPicard

    Retrieves information for the STPicard sticker pack from the Telegram Bot API.
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

    Some sticker authors use the same emoji for several of their stickers.


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
    Write-Verbose -Message "Asset path: $script:assetPath"
    $je = Get-Content -Path $script:assetPath
    $psF = $je | ConvertFrom-Json
    $stickerData = @()
    foreach ($emoji in $results.result.stickers) {
        #-------------------
        $emojiData = $null
        $code = $null
        $name = $null
        #-------------------
        $bytes = [text.encoding]::unicode.getbytes($emoji.emoji)
        # $actual = [System.Text.Encoding]::Unicode.GetString($bytes)
        # $emoji | Add-Member -Type NoteProperty -Name ActualEmoji -Value $actual -Force
        $emoji | Add-Member -Type NoteProperty -Name Bytes -Value $bytes -Force
        $emojiData = $psf | Where-Object { $_.KDDI -eq $emoji.emoji }
        $code = $emojiData.Sheet
        $name = $emojiData.Google
        $emoji | Add-Member -Type NoteProperty -Name Code -Value $code -Force
        $emoji | Add-Member -Type NoteProperty -Name Shortcode -Value $name -Force
        $stickerData += $emoji
    }

    return $stickerData
} #function_Get-TelegramStickerPackInfo
