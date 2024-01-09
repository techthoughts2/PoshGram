<#
.SYNOPSIS
    Sends Telegram animation message via Bot API from URL sourced animation image
.DESCRIPTION
    Uses Telegram Bot API to send animation message to specified Telegram chat. The animation will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $animationURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
    Send-TelegramURLAnimation -BotToken $botToken -ChatID $chat -AnimationURL $AnimationURL

    Sends animation message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $AnimationURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/jean.gif'
    $sendTelegramURLAnimationSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        AnimationURL        = $AnimationURL
        Caption             = 'Live long, and prosper.'
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramURLAnimation @sendTelegramURLAnimationSplat

    Sends animation message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $AnimationURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/jean.gif'
    $sendTelegramURLAnimationSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        AnimationURL        = $AnimationURL
        Caption             = 'Live __long__, and prosper\.'
        ParseMode           = 'MarkdownV2'
    }
    Send-TelegramURLAnimation @sendTelegramURLAnimationSplat

    Sends animation message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER AnimationURL
    URL path to animation
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
    animation               InputFile or String     Yes         Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended),
        pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files
    caption                 String                  Optional    Animation caption (may also be used when resending animation by file_id), 0-1024 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramURLAnimation
.LINK
    https://core.telegram.org/bots/api#sendanimation
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramURLAnimation {
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
            HelpMessage = 'URL path to animation')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$AnimationURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'animation caption')]
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

    Write-Verbose -Message 'Verifying URL leads to supported animation extension...'
    $fileTypeEval = Test-URLExtension -URL $AnimationURL -Type Animation
    if ($fileTypeEval -eq $false) {
        throw ('The specified animation URL: {0} does not contain a supported extension.' -f $AnimationURL)
    } #if_animationExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_animationExtension

    Write-Verbose -Message 'Verifying URL presence and file size...'
    $fileSizeEval = Test-URLFileSize -URL $AnimationURL
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_animationSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_animationSize

    $payload = @{
        chat_id              = $ChatID
        animation            = $AnimationURL
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #payload

    $uri = 'https://api.telegram.org/bot{0}/sendAnimation' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending animation...'
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
} #function_Send-TelegramURLAnimation
