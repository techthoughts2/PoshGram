<#
.SYNOPSIS
    Sends Telegram a group of photos, videos, documents, or audios as an album via Bot API from locally sourced media
.DESCRIPTION
    Uses Telegram Bot API to send a group of photos, videos, documents, or audios as an album message to specified Telegram chat.
    The media will be sourced from the local device and uploaded to telegram. This function only supports sending one media type per send (Photo | Video | Documents | Audio).
    2 files minimum and 10 files maximum are required for this function.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $sendTelegramMediaGroupSplat = @{
        BotToken  = $botToken
        ChatID    = $chatID
        MediaType = 'Photo'
        FilePaths = 'C:\photo\photo1.jpg', 'C:\photo\photo2.jpg'
    }
    Send-TelegramMediaGroup @sendTelegramMediaGroupSplat

    Uploads all provided photo files as album via Telegram Bot API.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $sendTelegramMediaGroupSplat = @{
        BotToken  = $botToken
        ChatID    = $chatID
        MediaType = 'Photo'
        FilePaths = (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)
    }
    Send-TelegramMediaGroup @sendTelegramMediaGroupSplat

    Retrieves all photo file paths from C:\PhotoGroup and uploads as photo album.
    Keep in mind that your location must have at least 2, but not more than 10 files.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $vPath = 'C:\VideoGroup'
    $vFiles = @(
        "$vPath\first_contact.mp4",
        "$vPath\root_beer.mp4"
    )
    $sendTelegramMediaGroupSplat = @{
        BotToken            = $botToken
        ChatID              = $chatID
        MediaType           = 'Video'
        FilePaths           = $vFiles
        DisableNotification = $true
        ProtectContent      = $true
    }
    Send-TelegramMediaGroup @sendTelegramMediaGroupSplat

    Uploads all provided video files as album via Telegram Bot API.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER MediaType
    Type of media to send
.PARAMETER FilePaths
    List of filepaths for media you want to send
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    This works with PowerShell Version: 6.1+

    The following photo types are supported:
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

    The following video types are supported:
    Telegram clients support mp4 videos

    The following audio types are supported:
    MP3, M4A

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

    ? This was really hard to make.
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters            Type                                                                              Required     Description
    chat_id               Integer or String                                                                  Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    media                 Array of InputMediaAudio, InputMediaDocument, InputMediaPhoto and InputMediaVideo  Yes         A JSON-serialized array describing photos and videos to be sent
    disable_notification  Boolean                                                                            Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramMediaGroup
.LINK
    https://core.telegram.org/bots/api#sendmediagroup
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramMediaGroup {
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
            HelpMessage = 'Type of media to send')]
        [ValidateSet('Photo', 'Video', 'Document', 'Audio')]
        [string]$MediaType,

        [Parameter(Mandatory = $false,
            HelpMessage = 'List of filepaths for media you want to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string[]]$FilePaths,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    $MediaType = $MediaType.ToLower()
    Write-Verbose -Message ('You have specified a media type of: {0}' -f $MediaType)

    Write-Verbose -Message 'Testing if media group meets requirements...'
    $mediaGroupReqsEval = Test-MediaGroupRequirements -MediaType $MediaType -FilePath $FilePaths
    if (-not $mediaGroupReqsEval) {
        throw 'Telegram media group requirements not met'
    }

    Write-Verbose -Message 'Forming serialized JSON for all media files...'
    $form = @{
        chat_id              = $ChatID;
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
        media                = ''
    }
    $json = @'
    [

'@

    $i = 1
    foreach ($file in $FilePaths) {
        $fInfo = $null
        try {
            $fInfo = Get-Item -Path $file -ErrorAction Stop
        }
        catch {
            throw ('An issue was encountered retrieving data from: {0}' -f $file)
        }
        $Form += @{"$MediaType$i" = $fInfo }
        $json += "{`"type`":`"$MediaType`",`"`media`":`"attach://$MediaType$i`"},"
        $i++
    }
    $json = $json.Substring(0, $json.Length - 1)

    $json += @'

]
'@

    $Form.media = $json
    Write-Verbose -Message 'JSON formation completed.'

    $uri = 'https://api.telegram.org/bot{0}/sendMediaGroup' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending media...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        ErrorAction = 'Stop'
        Form        = $form
        Method      = 'Post'
    }
    Write-Verbose -Message 'Sending media...'
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
        Write-Verbose -Message 'Media sent.'
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram media message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramMediaGroup
