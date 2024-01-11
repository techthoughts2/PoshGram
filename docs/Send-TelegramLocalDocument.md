---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalDocument
schema: 2.0.0
---

# Send-TelegramLocalDocument

## SYNOPSIS
Sends Telegram document message via Bot API from locally sourced file

## SYNTAX

```
Send-TelegramLocalDocument [-BotToken] <String> [-ChatID] <String> [-File] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [-DisableContentTypeDetection] [-DisableNotification] [-ProtectContent]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send document message to specified Telegram chat.
The document will be sourced from the local device and uploaded to Telegram.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$file = 'C:\Logs\Log1.txt'
Send-TelegramLocalDocument -BotToken $botToken -ChatID $chat -File $file
```

Sends document message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$file = 'C:\Logs\Log1.txt'
$sendTelegramLocalDocumentSplat = @{
    BotToken            = $botToken
    ChatID              = $chatID
    File                = $file
    Caption             = 'Check out this file'
    ParseMode           = 'MarkdownV2'
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat
```

Sends document message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$file = 'C:\Logs\Log1.txt'
$sendTelegramLocalDocumentSplat = @{
    BotToken  = $botToken
    ChatID    = $chatID
    File      = $file
    Caption   = 'Check out this __important__ file\.'
    ParseMode = 'MarkdownV2'
}
Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat
```

Sends document message via Telegram API with properly formatted underlined word and escaped special character.

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

### -File
Local path to file

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

### -Caption
Brief title or explanation for media

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 5
Default value: HTML
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableContentTypeDetection
set to HTML by default

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

Bots can currently send files of up to 50 MB in size, this limit may be changed in the future.

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalDocument](https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalDocument)

[https://core.telegram.org/bots/api#senddocument](https://core.telegram.org/bots/api#senddocument)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

