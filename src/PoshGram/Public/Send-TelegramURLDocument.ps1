<#
.Synopsis
    Sends Telegram document message via Bot API from URL sourced file
.DESCRIPTION
    Uses Telegram Bot API to send document message to specified Telegram chat. The file will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters. Only works for gif, pdf and zip files.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $fileURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/LogExample.zip'
    Send-TelegramURLDocument -BotToken $botToken -ChatID $chat -FileURL $fileURL

    Sends document message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $fileURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/LogExample.zip'
    $sendTelegramURLDocumentSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        FileURL             = $fileURL
        Caption             = 'Log Files'
        ParseMode           = 'MarkdownV2'
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramURLDocument @sendTelegramURLDocumentSplat

    Sends document message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $fileURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/LogExample.zip'
    $sendTelegramURLDocumentSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        FileURL   = $fileURL
        Caption   = 'Here are the __important__ Log Files\.'
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramURLDocument @sendTelegramURLDocumentSplat

    Sends document message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER FileURL
    URL path to file
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

    In sendDocument, sending by URL will currently only work for gif, pdf and zip files.

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters                      Type                    Required    Description
    chat_id                         Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    document                        InputFile or String     Yes         File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
    caption                         String                  Optional    Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode                      String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_content_type_detection  Boolean                 Optional    Disables automatic server-side content type detection for files uploaded using multipart/form-data
    disable_notification            Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramURLDocument
.LINK
    https://core.telegram.org/bots/api#senddocument
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramURLDocument {
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
            HelpMessage = 'URL path to file')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$FileURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'File caption')]
        [string]$Caption,

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Disables automatic server-side content type detection')]
        [switch]$DisableContentTypeDetection,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    Write-Verbose -Message 'Verifying URL leads to supported document extension...'
    $fileTypeEval = Test-URLExtension -URL $FileURL -Type Document
    if ($fileTypeEval -eq $false) {
        throw ('The specified file URL: {0} does not contain a supported extension.' -f $FileURL)
    } #if_documentExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_documentExtension

    Write-Verbose -Message 'Verifying URL presence and file size...'
    $fileSizeEval = Test-URLFileSize -URL $FileURL
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_documentSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_documentSize

    $payload = @{
        chat_id                        = $ChatID
        document                       = $FileURL
        caption                        = $Caption
        parse_mode                     = $ParseMode
        disable_content_type_detection = $DisableContentTypeDetection.IsPresent
        disable_notification           = $DisableNotification.IsPresent
        protect_content                = $ProtectContent.IsPresent
    } #payload

    $uri = 'https://api.telegram.org/bot{0}/sendDocument' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending document...'
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
} #function_Send-TelegramURLDocument
