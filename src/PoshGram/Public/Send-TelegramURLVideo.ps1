<#
.Synopsis
    Sends Telegram video message via Bot API from URL sourced file
.DESCRIPTION
    Uses Telegram Bot API to send video message to specified Telegram chat. The file will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters. Only works for gif, pdf and zip files.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $videourl = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Intro.mp4'
    Send-TelegramURLVideo -BotToken $botToken -ChatID $chat -VideoURL $videourl

    Sends video message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $videourl = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Intro.mp4'
    $sendTelegramURLVideoSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        VideoURL            = $videourl
        Duration            = 16
        Width               = 1920
        Height              = 1080
        FileName            = 'video.mp4'
        Caption             = 'Check out this video'
        ParseMode           = 'MarkdownV2'
        Streaming           = $true
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramURLVideo @sendTelegramURLVideoSplat

    Sends video message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $videourl = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Intro.mp4'
    $sendTelegramURLVideoSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        VideoURL  = $videourl
        ParseMode = 'MarkdownV2'
        FileName  = 'video.mp4'
        Caption   = 'Check out this __awesome__ video\.'
    }
    Send-TelegramURLVideo @sendTelegramURLVideoSplat

    Sends video message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER VideoURL
    URL path to video file
.PARAMETER Duration
    Duration of sent video in seconds
.PARAMETER Width
    Video width
.PARAMETER Height
    Video height
.PARAMETER FileName
    Original File Name
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER Streaming
    Use if the uploaded video is suitable for streaming
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Telegram clients support mp4 videos (other formats may be sent as Document)
    Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.

    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Markdown Style: This is a legacy mode, retained for backward compatibility.
    When using Markdown/Markdownv2 you must properly escape characters.
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    video                   InputFile or String     Yes         Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data.
    duration                Integer                 Optional    Duration of sent video in seconds
    width                   Integer                 Optional    Video width
    height                  Integer                 Optional    Video height
    caption                 String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    supports_streaming      Boolean                 Optional    Pass True, if the uploaded video is suitable for streaming
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLVideo.md
.LINK
    https://core.telegram.org/bots/api#sendvideo
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramURLVideo {
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
            HelpMessage = 'URL to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$VideoURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of video in seconds')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Duration,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Video width')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Width,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Video height')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Height,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Original File Name')]
        [string]$FileName,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = '', #set to false by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Use if the uploaded video is suitable for streaming')]
        [switch]$Streaming,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Verbose -Message 'Verifying URL leads to supported document extension...'
    $fileTypeEval = Test-URLExtension -URL $VideoURL -Type Video
    if ($fileTypeEval -eq $false) {
        throw ('The specified Video URL: {0} does not contain a supported extension.' -f $VideoURL)
    } #if_videoExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_videoExtension

    Write-Verbose -Message 'Verifying URL presence and file size...'
    $fileSizeEval = Test-URLFileSize -URL $VideoURL
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_videoSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_videoSize

    $payload = @{
        chat_id              = $ChatID
        video                = $VideoURL
        duration             = $Duration
        width                = $Width
        height               = $Height
        file_name            = $FileName
        caption              = $Caption
        parse_mode           = $ParseMode
        supports_streaming   = $Streaming
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #payload

    $uri = 'https://api.telegram.org/bot{0}/sendVideo' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending video...'
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
} #function_Send-TelegramURLVideo
