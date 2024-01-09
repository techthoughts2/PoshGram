<#
.SYNOPSIS
    Send a text message via Telegram Bot API.
.DESCRIPTION
    Uses Telegram Bot API to send text message to specified Telegram chat. Several options can be specified to adjust message parameters.

    Interfaces with the Telegram Bot API to send text messages to a specified Telegram chat. It supports various messaging options, including different parse modes, message delivery options, and custom keyboards.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"

    Sends text message via Telegram Bot API.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $message = 'This is how to use:
    <b>bold</b>,
    <i>italic</i>,
    <u>underline</u>,
    <s>strikethrough</s>,
    <tg-spoiler>spoiler</tg-spoiler>,
    <a href="http://www.example.com/">inline URL</a>,
    <code>inline fixed-width code</code>,
    <pre>pre-formatted fixed-width code block</pre>,
    <pre><code class="language-powershell">#pre-formatted fixed-width code block written in the PowerShell programming language</code></pre>
    <blockquote>Block quotation started\nBlock quotation continued\nThe last line of the block quotation</blockquote>
    with default HTML formatting.'
    $sendTelegramTextMessageSplat = @{
        BotToken = $botToken
        ChatID   = $chat
        Message  = $message
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends a text message through the Telegram Bot API using HTML for text formatting. This example illustrates how to apply various HTML tags like bold, italic, underline, strikethrough, and more to create richly formatted messages.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chatID = '-nnnnnnnnn'
    $message = 'This is how to use:
    *bold*,
    _italic_,
    __underline__,
    ~strikethrough~,
    ||spoiler||,
    [inline URL](http://www.example.com/),
    `inline fixed-width code`,,
    >Block quotation started
    >Block quotation continued
    >The last line of the block quotation
    with MarkdownV2 style formatting'
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        Message   = $message
        ParseMode = 'MarkdownV2'
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram API with properly formatted MarkdownV2 syntax.

    Sends a text message via the Telegram Bot API using MarkdownV2 syntax for text formatting. This example showcases the use of various MarkdownV2 formatting options, such as bold, italic, underline, strikethrough, and more, to create richly formatted messages.
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        ParseMode = 'MarkdownV2'
        Message   = 'This is how to escape an __underscore__ in a message: \_'
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram Bot API using MarkdownV2 syntax for text formatting. This example showcases an underlined word and a properly escaped character.
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        ParseMode = 'MarkdownV2'
        Message   = "`u{1F192} Sending emojis is cool\! `u{1F49B}"
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram Bot API using MarkdownV2 syntax for text formatting. This example showcases two properly escaped special character (!) and use of emojis.
.EXAMPLE
    $inlineRow1 = @(
    @{
        text = "`u{1F517} Visit"
        url  = 'https://www.techthoughts.info'
    }
    )
    $inlineRow2 = @(
        @{
            text = "`u{1F4CC} Pin"
            url  = 'https://www.techthoughts.info/learn-powershell-series/'
        }
    )
    $inlineKeyboard = @{
        inline_keyboard = @(
            $inlineRow1,
            $inlineRow2
        )
    }
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        Message   = 'Sending an example of inline keyboard'
        Keyboard  = $inlineKeyboard
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message with an inline keyboard right next to the message it belongs to.
.EXAMPLE
    $row1 = @(
        @{
            text = "`u{1F513} Unlock"
        }
    )
    $row2 = @(
        @{
            text = "`u{1F512} Lock"
        }
    )
    $customKeyboard = @{
        keyboard          = @(
            $row1,
            $row2
        )
        one_time_keyboard = $true
    }
    $sendTelegramTextMessageSplat = @{
        BotToken  = $botToken
        ChatID    = $chat
        Message   = 'Sending an example of a custom keyboard'
        Keyboard  = $customKeyboard
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message with a custom keyboard.
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken        = $botToken
        ChatID          = $chat
        Message         = 'Sending a protected content message'
        ProtectContent  = $true
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram Bot API and enables the 'ProtectContent' feature. When 'ProtectContent' is set to $true, it prevents the message from being forwarded or saved. This is useful for sending sensitive or confidential information that should remain within the confines of the original chat.
.EXAMPLE
    $sendTelegramTextMessageSplat = @{
        BotToken             = $botToken
        ChatID               = $chat
        Message              = 'Sending a message with a link preview'
        LinkPreviewURL       = 'https://www.techthoughts.info'
        LinkPreviewOption    = 'Small'
        LinkPreviewAboveText = $true
    }
    Send-TelegramTextMessage @sendTelegramTextMessageSplat

    Sends text message via Telegram Bot API and enables the 'LinkPreview' feature. When 'LinkPreview' is set to Small, it will generate a small link preview for the provided url. When 'LinkPreviewAboveText' is set to $true, it will display the link preview above the message text.
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Message
    Text of the message to be sent
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is HTML.
.PARAMETER LinkPreviewURL
    URL to use for the link preview. If empty, then the first URL found in the message text will be used. Has no effect if LinkPreviewOption is Disabled.
.PARAMETER LinkPreviewOption
    Choose how link previews are shown. Default is Disabled.
.PARAMETER LinkPreviewAboveText
    Use if the link preview must be shown above the message text. Has no effect if LinkPreviewOption is Disabled.
.PARAMETER Keyboard
    Custom or inline keyboard object
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

    Markdown Style: This is a legacy mode, retained for backward compatibility.
    When using Markdown/Markdownv2 you must properly escape characters.
    Certain characters in Telegram must be escaped with the preceding character '\' - see examples.

    See https://core.telegram.org/bots/api#inlinekeyboardbutton for additional details for forming inline keyboards.
    See https://core.telegram.org/bots/api#replykeyboardmarkup for additional details for forming custom keyboards.
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters                  Type                Required    Description
    chat_id                     Integer or String   Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    text                        String              Yes         Text of the message to be sent, 1-4096 characters after entities parsing
    parse_mode                  String              Optional    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    link_preview_options        LinkPreviewOptions  Optional    Link preview generation options for the message
    disable_notification        Boolean             Optional    Sends the message silently. Users will receive a notification with no sound.
    protect_content             Boolean             Optional    Protects the contents of the sent message from forwarding and saving
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramTextMessage/
.LINK
    https://core.telegram.org/bots/api#sendmessage
.LINK
    https://core.telegram.org/bots/api#html-style
.LINK
    https://core.telegram.org/bots/api#markdownv2-style
.LINK
    https://core.telegram.org/bots/api#markdown-style
.LINK
    https://core.telegram.org/bots/api#inlinekeyboardbutton
.LINK
    https://core.telegram.org/bots/api#replykeyboardmarkup
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramTextMessage {
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
            HelpMessage = 'Text of the message to be sent')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ParseMode = 'HTML', #set to HTML by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'URL to use for the link preview')]
        [ValidatePattern('^(http|https)://[a-zA-Z0-9-\.]+(\.[a-zA-Z]{2,})?(:[0-9]+)?(/.*)?$')]
        [string]$LinkPreviewURL,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Choose how link previews are shown')]
        [ValidateSet('Disabled', 'Small', 'Large')]
        [string]$LinkPreviewOption = 'Disabled', #set to Disabled by default

        [Parameter(Mandatory = $false,
            HelpMessage = 'Use if the link preview must be shown above the message text')]
        [switch]$LinkPreviewAboveText,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Custom or inline keyboard object')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [psobject]$Keyboard,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    $linkPreviewOptionsObj = @{
        is_disabled        = $false
        prefer_small_media = $true
        prefer_large_media = $true
        show_above_text    = $false
    }

    if ($LinkPreviewOption -eq 'Disabled') {
        $linkPreviewOptionsObj.is_disabled = $true
    }
    elseif ($LinkPreviewOption -eq 'Small') {
        $linkPreviewOptionsObj.prefer_small_media = $true
        $linkPreviewOptionsObj.prefer_large_media = $false
    }
    elseif ($LinkPreviewOption -eq 'Large') {
        $linkPreviewOptionsObj.prefer_small_media = $false
        $linkPreviewOptionsObj.prefer_large_media = $true
    }

    if ($LinkPreviewAboveText.IsPresent) {
        $linkPreviewOptionsObj.show_above_text = $true
    }

    if ($LinkPreviewURL) {
        $linkPreviewOptionsObj.Add('url', $LinkPreviewURL)
    }

    $payload = @{
        chat_id              = $ChatID
        text                 = $Message
        parse_mode           = $ParseMode
        link_preview_options = $linkPreviewOptionsObj
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #payload

    if ($Keyboard) {
        $payload.Add('reply_markup', $Keyboard)
    }

    $uri = 'https://api.telegram.org/bot{0}/sendMessage' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending message...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        Body        = ([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -Compress -InputObject $payload -Depth 50)))
        ErrorAction = 'Stop'
        ContentType = 'application/json'
        Method      = 'Post'
    }
    try {
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
} #function_Send-TelegramTextMessage
