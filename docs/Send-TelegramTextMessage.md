---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md
schema: 2.0.0
---

# Send-TelegramTextMessage

## SYNOPSIS
Sends Telegram text message via Bot API

## SYNTAX

```
Send-TelegramTextMessage [-BotToken] <String> [-ChatID] <String> [-Message] <String> [[-ParseMode] <String>]
 [[-Keyboard] <PSObject>] [-DisablePreview] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send text message to specified Telegram chat.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"
```

Sends text message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$sendTelegramTextMessageSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    Message   = 'This is how to use <b>bold</b>,<i>italic</i>,<u>underline</u>, and <s>strikethrough</s>, with default HTML formatting.'
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram API with properly formatted default HTML syntax.

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$sendTelegramTextMessageSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    Message             = 'Hello *chat* _channel_, check out this link: [TechThoughts](https://www.techthoughts.info/)'
    ParseMode           = 'MarkdownV2'
    DisablePreview      = $true
    DisableNotification = $true
    Verbose             = $true
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

Sends text message via Telegram API with properly formatted MarkdownV2 syntax.

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

Sends text message via Telegram API using MarkdownV2 with an underlined word and a properly escaped character.

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

Sends text message via Telegram API with two properly escaped special character (!) and emojis.

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
See https://core.telegram.org/bots/api#inlinekeyboardbutton for additional details for forming inline keyboards.

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
See https://core.telegram.org/bots/api#replykeyboardmarkup for additional details for forming custom keyboards.

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

### -Keyboard
Custom or inline keyboard object

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisablePreview
Disables link previews for links in this message.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

Markdown Style: This is a legacy mode, retained for backward compatibility.
When using Markdown/Markdownv2 you must properly escape characters.
Certain characters in Telegram must be escaped with the preceding character '\' - see examples.

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md)

[https://core.telegram.org/bots/api#sendmessage](https://core.telegram.org/bots/api#sendmessage)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

