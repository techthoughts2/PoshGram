<#
.Synopsis
    Sends Telegram sticker message via Bot API from URL sourced sticker image
.DESCRIPTION
    Uses Telegram Bot API to send sticker message to specified Telegram chat. The sticker will be sourced from the provided URL and sent to Telegram.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $StickerURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.webp'
    Send-TelegramURLSticker -BotToken $token -ChatID $channel -StickerURL $StickerURL

    Sends sticker message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $StickerURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.webp'
    $sendTelegramURLStickerSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        StickerURL          = $StickerURL
        DisableNotification = $true
        Verbose             = $true
    }
    Send-TelegramURLSticker @sendTelegramURLStickerSplat

    Sends sticker message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER StickerURL
    URL path to sticker
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

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
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLSticker.md
.LINK
    https://core.telegram.org/bots/api#sendsticker
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramURLSticker {
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
            HelpMessage = 'URL path to sticker')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$StickerURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Verbose -Message 'Verifying URL leads to supported sticker extension...'
    $fileTypeEval = Test-URLExtension -URL $StickerURL -Type Sticker
    if ($fileTypeEval -eq $false) {
        throw ('The specified sticker URL: {0} does not contain a supported extension.' -f $StickerURL)
    } #if_stickerExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_stickerExtension

    Write-Verbose -Message 'Verifying URL presence and file size...'
    $fileSizeEval = Test-URLFileSize -URL $StickerURL
    if ($fileSizeEval -eq $false) {
        throw 'File extension is not a supported Sticker type'
    } #if_stickerSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_stickerSize

    $payload = @{
        chat_id              = $ChatID
        sticker              = $StickerURL
        disable_notification = $DisableNotification.IsPresent
    } #payload

    $uri = 'https://api.telegram.org/bot{0}/sendSticker' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending sticker...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        Body        = (ConvertTo-Json -Compress -InputObject $payload)
        ErrorAction = 'Stop'
        ContentType = 'application/json'
        Method      = 'Post'
    }
    try {
        Write-Verbose -Message 'Sending message...'
        $results = Invoke-RestMethod @invokeRestMethodSplat
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramURLSticker
