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
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

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

    To find the name of a sticker pack use the telegram app to share the sticker pack. This will provide a link which contains the sticker pack name.
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
