<#
.Synopsis
    Sends Telegram sticker message via Bot API from locally sourced sticker image
.DESCRIPTION
    Uses Telegram Bot API to send sticker message to specified Telegram chat. The sticker will be sourced from the local device and uploaded to telegram.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $sticker = "C:\stickers\sticker.webp"
    Send-TelegramLocalSticker -BotToken $botToken -ChatID $chat -StickerPath $sticker

    Sends sticker message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $sticker = "C:\stickers\sticker.webp"
    Send-TelegramLocalSticker `
        -BotToken $botToken `
        -ChatID $chat `
        -StickerPath $sticker `
        -DisableNotification `
        -Verbose

    Sends sticker message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER StickerPath
    File path to the sticker you wish to send
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    The following sticker types are supported:
    WEBP, TGS

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    sticker                 InputFile or String     Yes         Sticker to send.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalSticker.md
.LINK
    https://core.telegram.org/bots/api#sendsticker
#>
function Send-TelegramLocalSticker {
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
            HelpMessage = 'File path to the sticker you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$StickerPath,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying presence of sticker..."
    if (!(Test-Path -Path $StickerPath)) {
        Write-Warning "The specified sticker path: $StickerPath was not found."
        $results = $false
        return $results
    }#if_testPath
    else {
        Write-Verbose -Message "Path verified."
    }#else_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying extension type..."
    $fileTypeEval = Test-FileExtension -FilePath $StickerPath -Type Sticker
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_stickerExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_stickerExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying file size..."
    $fileSizeEval = Test-FileSize -Path $StickerPath
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_stickerSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_stickerSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $StickerPath -ErrorAction Stop
    }#try_Get-ItemSticker
    catch {
        Write-Warning "The specified sticker could not be interpreted properly."
        $results = $false
        return $results
    }#catch_Get-ItemSticker
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendSticker"
    $Form = @{
        chat_id              = $ChatID
        sticker              = $fileObject
        disable_notification = $DisableNotification.IsPresent
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
        Write-Warning "An error was encountered sending the Telegram sticker message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocalSticker