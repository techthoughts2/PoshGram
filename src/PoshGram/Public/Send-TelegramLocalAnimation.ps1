<#
.Synopsis
    Sends Telegram animation message via Bot API from locally sourced animation
.DESCRIPTION
    Uses Telegram Bot API to send animation message to specified Telegram chat. The animation will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $animation = 'C:\animation\animation.gif'
    Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chat -AnimationPath $animation

    Sends AnimationPath message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $animation = 'C:\animation\animation.gif'
    $sendTelegramLocalAnimationSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        AnimationPath       = $animation
        Caption             = 'Check out this animation'
        ParseMode           = 'MarkdownV2'
        DisableNotification = $true
        Verbose             = $true
    }
    Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat

    Sends animation message via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $animation = 'C:\animation\animation.gif'
    $sendTelegramLocalAnimationSplat = @{
        BotToken      = $botToken
        ChatID        = $chat
        AnimationPath = $animation
        Caption       = 'Check out this __awesome__ animation\.'
        ParseMode     = 'MarkdownV2'
    }
    Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat

    Sends animation message via Telegram API with properly formatted underlined word and escaped special character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER AnimationPath
    File path to local image
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    The following animation types are supported:
    GIF

    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Get creative by sending Gifs with your bot!
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    animation               InputFile or String     Yes         Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended),
        pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files
    caption                 String                  Optional    Animation caption (may also be used when resending animation by file_id), 0-1024 characters
    parse_mode              String                  Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAnimation.md
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
function Send-TelegramLocalAnimation {
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
            HelpMessage = 'File path to the animation you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$AnimationPath,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Animation caption')]
        [string]$Caption = '', #set to false by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )

    Write-Verbose -Message 'Verifying presence of animation...'
    if (-not(Test-Path -Path $AnimationPath)) {
        throw ('The specified animation path: {0} was not found.' -f $AnimationPath)
    } #if_testPath
    else {
        Write-Verbose -Message 'Path verified.'
    } #else_testPath

    Write-Verbose -Message 'Verifying extension type...'
    $fileTypeEval = Test-FileExtension -FilePath $AnimationPath -Type Animation
    if ($fileTypeEval -eq $false) {
        throw 'File extension is not a supported Animation type'
    } #if_animationExtension
    else {
        Write-Verbose -Message 'Extension supported.'
    } #else_animationExtension

    Write-Verbose -Message 'Verifying file size...'
    $fileSizeEval = Test-FileSize -Path $AnimationPath
    if ($fileSizeEval -eq $false) {
        throw 'File size does not meet Telegram requirements'
    } #if_animationSize
    else {
        Write-Verbose -Message 'File size verified.'
    } #else_animationSize

    try {
        $fileObject = Get-Item $AnimationPath -ErrorAction Stop
    } #try_Get-ItemAnimation
    catch {
        Write-Warning -Message 'The specified animation could not be interpreted properly.'
        throw $_
    } #catch_Get-ItemAnimation

    $form = @{
        chat_id              = $ChatID
        animation            = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendAnimation' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

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
        Write-Warning -Message 'An error was encountered sending the Telegram animation message:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramLocalAnimation
