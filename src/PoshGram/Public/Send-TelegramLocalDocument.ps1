<#
.Synopsis
    Sends Telegram document message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send document message to specified Telegram chat. The document will be sourced from the local device and uploaded to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $file = 'C:\Logs\Log1.txt'
    Send-TelegramLocalDocument -BotToken $botToken -ChatID $chat -File $file

    Sends document message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $file = 'C:\Logs\Log1.txt'
    $sendTelegramLocalDocumentSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        File                = $file
        Caption             = 'Check out this file'
        ParseMode           = 'MarkdownV2'
        DisableNotification = $true
        Verbose             = $true
    }
    Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat

    Sends document message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $file = 'C:\Logs\Log1.txt'
    $sendTelegramLocalDocumentSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        File      = $file
        Caption   = 'Check out this __important__ file\.'
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat

    Sends document message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER File
    Local path to file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    Bots can currently send files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters                      Type                    Required    Description
    chat_id                         Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    document                        InputFile or String     Yes         File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
    caption                         String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode                      String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_content_type_detection  Boolean                 Optional    Disables automatic server-side content type detection for files uploaded using multipart/form-data
    disable_notification            Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalDocument.md
.LINK
    https://core.telegram.org/bots/api#senddocument
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
#>
function Send-TelegramLocalDocument {
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
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$File,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = '', #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Disables automatic server-side content type detection')]
        [switch]$DisableContentTypeDetection,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message 'Verifying presence of file...'
    if (!(Test-Path -Path $File)) {
        Write-Warning -Message "The specified file: $File was not found."
        $results = $false
        return $results
    } #if_testPath
    else {
        Write-Verbose -Message 'Path verified.'
    } #else_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message 'Verifying file size...'
    $fileSizeEval = Test-FileSize -Path $File
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    } #if_photoSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_photoSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $File -ErrorAction Stop
    } #try_Get-ItemPhoto
    catch {
        Write-Warning -Message 'The specified file could not be interpreted properly.'
        $results = $false
        return $results
    } #catch_Get-ItemPhoto
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendDocument"
    $Form = @{
        chat_id                        = $ChatID
        document                       = $fileObject
        caption                        = $Caption
        parse_mode                     = $ParseMode
        disable_content_type_detection = $DisableContentTypeDetection.IsPresent
        disable_notification           = $DisableNotification.IsPresent
    } #form
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
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram document message:'
        Write-Error $_
        $results = $false
    } #catch_messageSend
    return $results
    #------------------------------------------------------------------------
} #function_Send-TelegramLocalDocument
