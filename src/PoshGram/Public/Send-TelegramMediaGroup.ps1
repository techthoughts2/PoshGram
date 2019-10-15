<#
.Synopsis
    Sends Telegram a group of photos or videos as an album via Bot API from locally sourced media
.DESCRIPTION
    Uses Telegram Bot API to send a group of photo or video as an album message to specified Telegram chat.
    The media will be sourced from the local device and uploaded to telegram. This function only supports sending one media type per send (Photo | Video).
    2 files minimum and 10 files maximum are required for this function.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    Send-TelegramMediaGroup `
        -BotToken $botToken `
        -ChatID $chat `
        -MediaType Photo `
        -FilePaths "C:\photo\photo1.jpg","C:\photo\photo2.jpg"

    Uploads all provided photo files as album via Telegram Bot API.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    Send-TelegramMediaGroup `
        -BotToken $botToken `
        -ChatID $chat `
        -MediaType Photo `
        -FilePaths (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)

    Retrieves all photo file paths from C:\PhotoGroup and uploads as photo album.
    Keep in mind that your location must have at least 2, but not more than 10 files.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $vPath = 'C:\VideoGroup'
    $vFiles = @(
        "$vPath\first_contact.mp4",
        "$vPath\root_beer.mp4"
    )
    Send-TelegramMediaGroup `
        -BotToken $botToken `
        -ChatID $chat `
        -MediaType Video `
        -FilePaths $vFiles `
        -DisableNotification

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
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Version: 6.1

    The following photo types are supported:
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

    The following video types are supported:
    Telegram clients support mp4 videos

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    ? This was really hard to make.
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters            Type                  Required    Description
    chat_id               Integer or String     Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    media                 Array of Photo/Video  Yes         A JSON-serialized array describing photos and videos to be sent
    disable_notification  Boolean               Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramMediaGroup.md
.LINK
    https://core.telegram.org/bots/api#sendmediagroup
#>
function Send-TelegramMediaGroup {
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
            HelpMessage = 'Type of media to send')]
        [ValidateSet("Photo", "Video")]
        [string]$MediaType, #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'List of filepaths for media you want to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string[]]$FilePaths,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    $MediaType = $MediaType.ToLower()
    #------------------------------------------------------------------------
    Write-Verbose -Message "Evaluating file count..."
    if ($FilePaths.Count -le 1 -or $FilePaths.Count -gt 10) {
        Write-Warning -Message "Send-TelegramMediaGroup requires a minimum of 2 and a maximum of 10 media files to be provided."
        $results = $false
        return $results
    }#file_Count
    else {
        Write-Verbose -Message "File count is: $($FilePaths.Count)"
    }#else_FileCount
    #------------------------------------------------------------------------
    Write-Verbose -Message "You have specified a media type of: $MediaType"
    #------------------------------------------------------------------------
    foreach ($file in $FilePaths) {
        $fileTypeEval = $null
        $fileSizeEval = $null
        Write-Verbose -Message "Verifying presence of media..."
        if (!(Test-Path -Path $file)) {
            Write-Warning "The specified media path: $file was not found."
            $results = $false
            return $results
        }#if_testPath
        Write-Verbose -Message "Verifying extension type..."
        $fileTypeEval = Test-FileExtension -FilePath $file -Type $MediaType
        if ($fileTypeEval -eq $false) {
            $results = $false
            return $results
        }#if_Extension
        else {
            Write-Verbose -Message "Extension supported."
        }#else_Extension
        Write-Verbose -Message "Verifying file size..."
        $fileSizeEval = Test-FileSize -Path $file
        if ($fileSizeEval -eq $false) {
            $results = $false
            return $results
        }#if_Size
        else {
            Write-Verbose -Message "File size verified."
        }#else_Size
    }#foreach_File
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendMediaGroup"
    #------------------------------------------------------------------------
    Write-Verbose -Message "Forming serialzied JSON for all media files..."
    $Form = @{
        chat_id              = $ChatID;
        disable_notification = $DisableNotification.IsPresent
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
            Write-Warning -Message "An issue was encountered retrieving data from: $file"
            $results = $false
            return $results
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
    Write-Verbose -Message "JSON formation completed."
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = $Uri
        ErrorAction = 'Stop'
        Form        = $Form
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    Write-Verbose -Message "Sending media..."
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
        Write-Verbose -Message "Media sent."
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram photo message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramMediaGroup
