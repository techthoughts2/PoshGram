<#
.Synopsis
    Sends Telegram audio message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send audio message to specified Telegram chat. The audio will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters. Telegram only supports mp3 audio.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $audio = 'C:\audio\halo_on_fire.mp3'
    Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio

    Sends audio message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $audio = 'C:\audio\halo_on_fire.mp3'
    $sendTelegramLocalAudioSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        Audio               = $audio
        Caption             = 'Check out this audio track'
        ParseMode           = 'MarkdownV2'
        Duration            = 495
        Performer           = 'Metallica'
        Title               = 'Halo On Fire'
        FileName            = 'halo_on_fire.mp3'
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramLocalAudio @sendTelegramLocalAudioSplat

    Sends audio message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $audio = 'C:\audio\halo_on_fire.mp3'
    $sendTelegramLocalAudioSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        Audio     = $audio
        Performer = 'Metallica'
        Title     = 'Halo On Fire'
        FileName  = 'halo_on_fire.mp3'
        Caption   = 'Check out this __awesome__ audio track\.'
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramLocalAudio @sendTelegramLocalAudioSplat

    Sends audio message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Audio
    Local path to audio file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER Performer
    Performer
.PARAMETER Title
    Track Name
.PARAMETER FileName
    Original File Name
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Your audio must be in the .mp3 format.
    Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    audio                   InputFile or String     Yes         Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data.
    caption                 String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    duration                Integer                 Optional    Duration of the audio in seconds
    performer               String                  Optional    Performer
    title                   String                  Optional    Track Name
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalAudio
.LINK
    https://core.telegram.org/bots/api#sendaudio
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramLocalAudio {
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
        [string]$Audio,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = '', #set to false by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of the audio in seconds')]
        [int]$Duration,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Performer')]
        [string]$Performer,

        [Parameter(Mandatory = $false,
            HelpMessage = 'TrackName')]
        [string]$Title,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Original File Name')]
        [string]$FileName,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Verbose -Message 'Verifying presence of file...'
    if (-not(Test-Path -Path $Audio)) {
        throw ('The specified file was not found {0}' -f $Audio)
    } #if_testPath
    else {
        Write-Verbose -Message 'Path verified.'
    } #else_testPath

    Write-Verbose -Message 'Verifying extension type...'
    $fileTypeEval = Test-FileExtension -FilePath $Audio -Type Audio
    if ($fileTypeEval -eq $false) {
        throw 'File extension is not a supported Audio type'
    } #if_audioExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_audioExtension

    Write-Verbose -Message 'Verifying file size...'
    $fileSizeEval = Test-FileSize -Path $Audio
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_audioSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_audioSize

    Write-Verbose -Message 'Getting audio file...'
    try {
        $fileObject = Get-Item $Audio -ErrorAction Stop
    } #try_Get-ItemAudio
    catch {
        Write-Warning -Message 'The specified audio could not be interpreted properly.'
        throw $_
    } #catch_Get-ItemAudio

    $form = @{
        chat_id              = $ChatID
        audio                = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        duration             = $Duration
        performer            = $Performer
        title                = $Title
        file_name            = $FileName
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendAudio' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending audio...'
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
        Write-Warning -Message 'An error was encountered sending the Telegram audio message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramLocalAudio
