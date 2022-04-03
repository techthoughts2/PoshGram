<#
.Synopsis
    Sends Telegram photo message via Bot API from locally sourced photo image
.DESCRIPTION
    Uses Telegram Bot API to send photo message to specified Telegram chat. The photo will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $photo = 'C:\photos\aphoto.jpg'
    Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chat -PhotoPath $photo

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $photo = 'C:\photos\aphoto.jpg'
    $sendTelegramLocalPhotoSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        PhotoPath           = $photo
        Caption             = 'Check out this photo'
        ParseMode           = 'MarkdownV2'
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $photo = 'C:\photos\aphoto.jpg'
    $sendTelegramLocalPhotoSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        PhotoPath = $photo
        Caption   = 'Check out this __awesome__ photo\.'
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat

    Sends photo message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER PhotoPath
    File path to local image
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

    The following photo types are supported:
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    photo                   InputFile or String     Yes         Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended),
        pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files
    caption                 String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md
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
function Send-TelegramLocalPhoto {
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
            HelpMessage = 'File path to the photo you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PhotoPath,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Photo caption')]
        [string]$Caption = '', #set to false by default

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

    Write-Verbose -Message 'Verifying presence of photo...'
    if (-not(Test-Path -Path $PhotoPath)) {
        throw ('The specified photo path: {0} was not found.' -f $PhotoPath)
    } #if_testPath
    else {
        Write-Verbose -Message 'Path verified.'
    } #else_testPath

    Write-Verbose -Message 'Verifying extension type...'
    $fileTypeEval = Test-FileExtension -FilePath $PhotoPath -Type Photo
    if ($fileTypeEval -eq $false) {
        throw 'File extension is not a supported Photo type'
    } #if_photoExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_photoExtension

    Write-Verbose -Message 'Verifying file size...'
    $fileSizeEval = Test-FileSize -Path $PhotoPath
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_photoSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_photoSize

    Write-Verbose -Message 'Getting photo file...'
    try {
        $fileObject = Get-Item $PhotoPath -ErrorAction Stop
    } #try_Get-ItemPhoto
    catch {
        Write-Warning -Message 'The specified photo could not be interpreted properly.'
        throw $_
    } #catch_Get-ItemPhoto

    $form = @{
        chat_id              = $ChatID
        photo                = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendphoto' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending photo...'
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
        Write-Warning -Message 'An error was encountered sending the Telegram photo message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramLocalPhoto
