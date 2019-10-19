<#
.Synopsis
    Sends Telegram animation message via Bot API from URL sourced animation image
.DESCRIPTION
    Uses Telegram Bot API to send animation message to specified Telegram chat. The animation will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $animationURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
    Send-TelegramURLAnimation -BotToken $botToken -ChatID $chat -AnimationURL $AnimationURL

    Sends animation message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $AnimationURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/jean.gif"
    Send-TelegramURLAnimation `
        -BotToken $botToken `
        -ChatID $chat `
        -AnimationURL $AnimationURL `
        -Caption "Live long, and prosper." `
        -ParseMode Markdown `
        -DisableNotification `
        -Verbose

    Sends animation message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER AnimationURL
    URL path to animation
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1+

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
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
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLAnimation.md
.LINK
    https://core.telegram.org/bots/api#sendanimation
#>
function Send-TelegramURLAnimation {
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
            HelpMessage = 'URL path to animation')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$AnimationURL,
        [Parameter(Mandatory = $false,
            HelpMessage = 'animation caption')]
        [string]$Caption,
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL leads to supported animation extension..."
    $fileTypeEval = Test-URLExtension -URL $AnimationURL -Type Animation
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_documentExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL presence and file size..."
    $fileSizeEval = Test-URLFileSize -URL $AnimationURL
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_animationSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_animationSize
    #------------------------------------------------------------------------
    $payload = @{
        "chat_id"              = $ChatID
        "animation"            = $AnimationURL
        "caption"              = $Caption
        "parse_mode"           = $ParseMode
        "disable_notification" = $DisableNotification.IsPresent
    }#payload
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = ("https://api.telegram.org/bot{0}/sendAnimation" -f $BotToken)
        Body        = (ConvertTo-Json -Compress -InputObject $payload)
        ErrorAction = 'Stop'
        ContentType = "application/json"
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod @invokeRestMethodSplat
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramURLAnimation