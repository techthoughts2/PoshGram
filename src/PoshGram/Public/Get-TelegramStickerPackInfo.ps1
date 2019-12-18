<#
.Synopsis
    Get information for specified Telegram sticker pack.
.DESCRIPTION
    Uses Telegram Bot API to retrieve Telegram sticker pack information. Displays emoji,emoji code, emoji shortcode, bytes, and file_id, and file information for each sticker in the sticker pack.
.EXAMPLE
    Get-TelegramStickerPackInfo -BotToken $token -StickerSetName STPicard

    Sends contact via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER StickerSetName
    Name of the sticker set
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Some sticker authors use the same emoji for several of their stickers.

    width       : 512
    height      : 512
    emoji       : 🙂
    set_name    : STPicard
    is_animated : False
    thumb       : @{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}
    file_id     : CAADAgADDAAD3XATF5dBRoC9vn3aFgQ
    file_size   : 18356
    Bytes       : {61, 216, 66, 222}
    Code        : U+1F642
    Shortcode   : :slightly_smiling_face:
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameter               Type                    Required    Description
    name                    String                  Yes         Name of the sticker set
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Get-TelegramStickerPackInfo.md
.LINK
    https://core.telegram.org/bots/api#getstickerset
.LINK
    https://core.telegram.org/bots/api#sticker
#>
function Get-TelegramStickerPackInfo {
    [CmdletBinding()]
    Param
    (
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
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/getStickerSet"

    $Form = @{
        name = $StickerSetName
    }#form
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = $Uri
        ErrorAction = 'Stop'
        Form        = $Form
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    Write-Verbose -Message 'Retrieving sticker information...'
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    }#try_messageSend
    catch {
        $theError = $_
        $errorEval = $theError.ErrorDetails.Message
        if ($errorEval) {
            $errorEval = $theError.ErrorDetails.Message | ConvertFrom-Json
        }
        if ($errorEval -like "*STICKERSET_INVALID*") {
            Write-Warning "STICKERSET_INVALID"

        }
        else {
            Write-Warning "An error was encountered retrieving sticker information:"
            Write-Error $_
        }
        $results = $false
        return $results
    }#catch_messageSend
    #------------------------------------------------------------------------
    Write-Verbose -Message 'Sticker information found. Processing emoji information...'
    Write-Verbose "Asset path: $script:assetPath"
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
}#function_Get-TelegramStickerPackInfo