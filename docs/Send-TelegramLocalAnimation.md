---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAnimation.md
schema: 2.0.0
---

# Send-TelegramLocalAnimation

## SYNOPSIS
Sends Telegram animation message via Bot API from locally sourced animation

## SYNTAX

```
Send-TelegramLocalAnimation [-BotToken] <String> [-ChatID] <String> [-AnimationPath] <String>
 [[-Caption] <String>] [[-ParseMode] <String>] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send animation message to specified Telegram chat.
The animation will be sourced from the local device and uploaded to telegram.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$animation = "C:\animation\animation.gif"
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chat -AnimationPath $animation

Sends AnimationPath message via Telegram API

### EXAMPLE 2
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$animation = "C:\animation\animation.gif"
Send-TelegramLocalAnimation \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -AnimationPath $animation \`
    -Caption "Check out this animation" \`
    -ParseMode Markdown \`
    -DisableNotification \`
    -Verbose

Sends animation message via Telegram API

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

### -AnimationPath
File path to local image

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
Default is Markdown.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Markdown
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
This works with PowerShell Version: 6.1+

The following animation types are supported:
GIF

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

Get creative by sending Gifs with your bot!

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAnimation.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAnimation.md)

[https://core.telegram.org/bots/api#sendanimation](https://core.telegram.org/bots/api#sendanimation)

