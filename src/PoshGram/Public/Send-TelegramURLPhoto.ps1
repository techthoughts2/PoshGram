<#
.SYNOPSIS
    Sends Telegram photo message via Bot API from URL sourced photo image
.DESCRIPTION
    Uses Telegram Bot API to send photo message to specified Telegram chat. The photo will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $photoURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
    Send-TelegramURLPhoto -BotToken $botToken -ChatID $chat -PhotoURL $photourl

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $photoURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
    $sendTelegramURLPhotoSplat = @{
        BotToken            = $botToken
        ChatID              = $chatID
        PhotoURL            = $photourl
        Caption             = 'DSC is a great technology'
        ParseMode           = 'MarkdownV2'
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramURLPhoto @sendTelegramURLPhotoSplat

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $photoURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
    $sendTelegramURLPhotoSplat = @{
        BotToken  = $botToken
        ChatID    = $chatID
        PhotoURL  = $photourl
        Caption   = "DSC is a __great__ technology\."
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramURLPhoto @sendTelegramURLPhotoSplat

    Sends photo message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER PhotoURL
    URL path to photo
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
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
    photo                   InputFile or string     Yes         Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended),
        pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files
    caption                 String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramURLPhoto
.LINK
    https://core.telegram.org/bots/api#sendphoto
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramURLPhoto {
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
            HelpMessage = 'URL path to photo')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PhotoURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Photo caption')]
        [string]$Caption,

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Verbose -Message 'Verifying URL leads to supported photo extension...'
    $fileTypeEval = Test-URLExtension -URL $PhotoURL -Type Photo
    if ($fileTypeEval -eq $false) {
        throw ('The specified photo URL: {0} does not contain a supported extension.' -f $AnimationURL)
    } #if_photoExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_photoExtension

    Write-Verbose -Message 'Verifying URL presence and file size...'
    $fileSizeEval = Test-URLFileSize -URL $PhotoURL
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_photoSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_photoSize

    $payload = @{
        chat_id              = $ChatID
        photo                = $PhotoURL
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #payload

    $uri = 'https://api.telegram.org/bot{0}/sendphoto' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending photo...'
    $invokeRestMethodSplat = @{
        Uri         = ('https://api.telegram.org/bot{0}/sendphoto' -f $BotToken)
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
} #function_Send-TelegramURLPhoto
