<#
.SYNOPSIS
    Sends Telegram video message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send video message to specified Telegram chat. The video will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters. Telegram only supports mp4 videos.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $file = 'C:\videos\video.mp4'
    Send-TelegramLocalVideo -BotToken $botToken -ChatID $chat -Video $video

    Sends video message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $video = 'C:\videos\video.mp4'
    $sendTelegramLocalVideoSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        Video               = $video
        Duration            = 10
        Width               = 250
        Height              = 250
        FileName            = 'video.mp4'
        Caption             = 'Check out this video'
        ParseMode           = 'MarkdownV2'
        HasSpoiler          = $true
        Streaming           = $true
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramLocalVideo @sendTelegramLocalVideoSplat

    Sends video message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $video = 'C:\videos\video.mp4'
    $sendTelegramLocalVideoSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        Video     = $video
        Streaming = $true
        FileName  = 'video.mp4'
        Caption   = 'Check out this __awesome__ video\.'
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramLocalVideo @sendTelegramLocalVideoSplat

    Sends video message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Video
    Local path to video file
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
.PARAMETER HasSpoiler
    Video needs to be covered with a spoiler animation
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

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    video                   InputFile or String     Yes         Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data.
    duration                Integer                 Optional    Duration of sent video in seconds
    width                   Integer                 Optional    Video width
    height                  Integer                 Optional    Video height
    caption                 String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    has_spoiler             Boolean                 Optional    Pass True if the video needs to be covered with a spoiler animation
    supports_streaming      Boolean                 Optional    Pass True, if the uploaded video is suitable for streaming
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
    protect_content         Boolean                 Optional    Protects the contents of the sent message from forwarding and saving
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalVideo
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
function Send-TelegramLocalVideo {
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
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Video,

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
            HelpMessage = 'Video needs to be covered with a spoiler animation')]
        [switch]$HasSpoiler,

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

    Write-Verbose -Message 'Verifying presence of file...'
    if (-not(Test-Path -Path $Video)) {
        throw ('The specified video file: {0} was not found.' -f $Video)
    } #if_testPath
    else {
        Write-Verbose -Message 'Path verified.'
    } #else_testPath

    Write-Verbose -Message 'Verifying extension type...'
    $fileTypeEval = Test-FileExtension -FilePath $Video -Type Video
    if ($fileTypeEval -eq $false) {
        throw 'File extension is not a supported Video type'
    } #if_videoExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_videoExtension

    Write-Verbose -Message 'Verifying file size...'
    $fileSizeEval = Test-FileSize -Path $Video
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_videoSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_videoSize

    Write-Verbose -Message 'Getting video file...'
    try {
        $fileObject = Get-Item $Video -ErrorAction Stop
    } #try_Get-ItemVideo
    catch {
        Write-Warning -Message 'The specified video file could not be interpreted properly.'
        throw $_
    } #catch_Get-ItemVideo

    $form = @{
        chat_id              = $ChatID
        video                = $fileObject
        duration             = $Duration
        width                = $Width
        height               = $Height
        file_name            = $FileName
        caption              = $Caption
        parse_mode           = $ParseMode
        has_spoiler          = $HasSpoiler.IsPresent
        supports_streaming   = $Streaming.IsPresent
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendVideo' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending video...'
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
        Write-Warning -Message 'An error was encountered sending the Telegram video message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramLocalVideo
