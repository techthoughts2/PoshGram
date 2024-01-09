---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramTextMessage/
schema: 2.0.0
---

# Send-TelegramTextMessage

## SYNOPSIS
Send a text message via Telegram Bot API.

## SYNTAX

```
Send-TelegramTextMessage [-BotToken] <String> [-ChatID] <String> [-Message] <String> [[-ParseMode] <String>]
 [[-LinkPreviewURL] <String>] [[-LinkPreviewOption] <String>] [-LinkPreviewAboveText] [[-Keyboard] <PSObject>]
 [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send text message to specified Telegram chat.
Several options can be specified to adjust message parameters.

Interfaces with the Telegram Bot API to send text messages to a specified Telegram chat.
It supports various messaging options, including different parse modes, message delivery options, and custom keyboards.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"
```

Sends text message via Telegram Bot API.

### EXAMPLE 2
```
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
```

Sends a text message through the Telegram Bot API using HTML for text formatting.
This example illustrates how to apply various HTML tags like bold, italic, underline, strikethrough, and more to create richly formatted messages.

### EXAMPLE 3
```
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
```

Sends text message via Telegram API with properly formatted MarkdownV2 syntax.

Sends a text message via the Telegram Bot API using MarkdownV2 syntax for text formatting.
This example showcases the use of various MarkdownV2 formatting options, such as bold, italic, underline, strikethrough, and more, to create richly formatted messages.

### EXAMPLE 4
```
$sendTelegramTextMessageSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    ParseMode = 'MarkdownV2'
    Message   = 'This is how to escape an __underscore__ in a message: \_'
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram Bot API using MarkdownV2 syntax for text formatting.
This example showcases an underlined word and a properly escaped character.

### EXAMPLE 5
```
$sendTelegramTextMessageSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    ParseMode = 'MarkdownV2'
    Message   = "`u{1F192} Sending emojis is cool\! `u{1F49B}"
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram Bot API using MarkdownV2 syntax for text formatting.
This example showcases two properly escaped special character (!) and use of emojis.

### EXAMPLE 6
```
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
```

Sends text message with an inline keyboard right next to the message it belongs to.

### EXAMPLE 7
```
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
```

Sends text message with a custom keyboard.

### EXAMPLE 8
```
$sendTelegramTextMessageSplat = @{
    BotToken        = $botToken
    ChatID          = $chat
    Message         = 'Sending a protected content message'
    ProtectContent  = $true
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram Bot API and enables the 'ProtectContent' feature.
When 'ProtectContent' is set to $true, it prevents the message from being forwarded or saved.
This is useful for sending sensitive or confidential information that should remain within the confines of the original chat.

### EXAMPLE 9
```
$sendTelegramTextMessageSplat = @{
    BotToken             = $botToken
    ChatID               = $chat
    Message              = 'Sending a message with a link preview'
    LinkPreviewURL       = 'https://www.techthoughts.info'
    LinkPreviewOption    = 'Small'
    LinkPreviewAboveText = $true
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram Bot API and enables the 'LinkPreview' feature.
When 'LinkPreview' is set to Small, it will generate a small link preview for the provided url.
When 'LinkPreviewAboveText' is set to $true, it will display the link preview above the message text.

## PARAMETERS

### -BotToken
Use this token to access the HTTP API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChatID
Unique identifier for the target chat

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Text of the message to be sent

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParseMode
Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
Default is HTML.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: HTML
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkPreviewURL
URL to use for the link preview.
If empty, then the first URL found in the message text will be used.
Has no effect if LinkPreviewOption is Disabled.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkPreviewOption
Choose how link previews are shown.
Default is Disabled.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Disabled
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkPreviewAboveText
Use if the link preview must be shown above the message text.
Has no effect if LinkPreviewOption is Disabled.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Keyboard
Custom or inline keyboard object

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableNotification
Send the message silently.
Users will receive a notification with no sound.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProtectContent
Protects the contents of the sent message from forwarding and saving

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

Markdown Style: This is a legacy mode, retained for backward compatibility.
When using Markdown/Markdownv2 you must properly escape characters.
Certain characters in Telegram must be escaped with the preceding character '\' - see examples.

See https://core.telegram.org/bots/api#inlinekeyboardbutton for additional details for forming inline keyboards.
See https://core.telegram.org/bots/api#replykeyboardmarkup for additional details for forming custom keyboards.

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramTextMessage/](https://poshgram.readthedocs.io/en/latest/Send-TelegramTextMessage/)

[https://core.telegram.org/bots/api#sendmessage](https://core.telegram.org/bots/api#sendmessage)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

[https://core.telegram.org/bots/api#inlinekeyboardbutton](https://core.telegram.org/bots/api#inlinekeyboardbutton)

[https://core.telegram.org/bots/api#replykeyboardmarkup](https://core.telegram.org/bots/api#replykeyboardmarkup)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

