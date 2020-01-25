<#
.Synopsis
    Sends Telegram text message via Bot API
.DESCRIPTION
    Uses Telegram Bot API to send text message to specified Telegram chat. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"

    Sends text message via Telegram API
.EXAMPLE
    $botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    Send-TelegramTextMessage `
        -BotToken $botToken `
        -ChatID $chat `
        -Message "Hello *chat* _channel_, check out this link: [TechThoughts](https://techthoughts.info/)" `
        -ParseMode MarkdownV2 `
        -DisablePreview `
        -DisableNotification `
        -Verbose

    Sends text message via Telegram API
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken = $botToken
        ChatID = $chat
        ParseMode = 'MarkdownV2'
        Message = 'This is how to escape an underscore in a message: \_'
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram API using MarkdownV2 with a properly escaped character.
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        ParseMode = 'MarkdownV2'
        Message   = 'You can underline __words__ in messages\.'
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram API using MarkdownV2 with an underlined word and a properly escaped character.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Message
    Text of the message to be sent
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER DisablePreview
    Disables link previews for links in this message.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6+, 7+
    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Markdown Style: This is a legacy mode, retained for backward compatibility.
    When using Markdown/Markdownv2 you must properly escape characters.
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters                  Type                Required    Description
    chat_id                     Integer or String   Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    text                        String              Yes         Text of the message to be sent
    parse_mode                  String              Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    disable_web_page_preview    Boolean             Optional    Disables link previews for links in this message
    disable_notification        Boolean             Optional    Sends the message silently. Users will receive a notification with no sound.
    reply_to_message_id         Integer             Optional    If the message is a reply, ID of the original message
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md
.LINK
    https://core.telegram.org/bots/api#sendmessage
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
#>
function Send-TelegramTextMessage {
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
            HelpMessage = 'Text of the message to be sent')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Message,
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Disables link previews')]
        [switch]$DisablePreview, #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    #return $DisableNotification
    $payload = @{
        chat_id                  = $ChatID
        text                     = $Message
        parse_mode               = $ParseMode
        disable_web_page_preview = $DisablePreview.IsPresent
        disable_notification     = $DisableNotification.IsPresent
    }#payload
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = ("https://api.telegram.org/bot{0}/sendMessage" -f $BotToken)
        Body        = ([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -Compress -InputObject $payload)))
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
}#function_Send-TelegramTextMessage