---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md
schema: 2.0.0
---

# Send-TelegramURLDocument

## SYNOPSIS
Sends Telegram document message via Bot API from URL sourced file

## SYNTAX

```
Send-TelegramURLDocument [-BotToken] <String> [-ChatID] <String> [-FileURL] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [-DisableContentTypeDetection] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send document message to specified Telegram chat.
The file will be sourced from the provided URL and sent to Telegram.
Several options can be specified to adjust message parameters.
Only works for gif, pdf and zip files.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$fileURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip'
Send-TelegramURLDocument -BotToken $botToken -ChatID $chat -FileURL $fileURL
```

Sends document message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$fileURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip'
$sendTelegramURLDocumentSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    FileURL             = $fileURL
    Caption             = 'Log Files'
    ParseMode           = 'MarkdownV2'
    DisableNotification = $true
    Verbose             = $true
}
Send-TelegramURLDocument @sendTelegramURLDocumentSplat
```

Sends document message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$fileURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip'
$sendTelegramURLDocumentSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    FileURL   = $fileURL
    Caption   = 'Here are the __important__ Log Files\.'
    ParseMode = 'MarkdownV2'
}
Send-TelegramURLDocument @sendTelegramURLDocumentSplat
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

### -FileURL
URL path to file

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject (if successful)
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
This works with PowerShell Versions: 5.1, 6.0, 6.1+

In sendDocument, sending by URL will currently only work for gif, pdf and zip files.

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md)

[https://core.telegram.org/bots/api#senddocument](https://core.telegram.org/bots/api#senddocument)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

