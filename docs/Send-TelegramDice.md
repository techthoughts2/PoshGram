---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramDice.md
schema: 2.0.0
---

# Send-TelegramDice

## SYNOPSIS
Sends Telegram animated emoji that will display a random value.

## SYNTAX

```
Send-TelegramDice [-BotToken] <String> [-ChatID] <String> [-Emoji] <String> [-DisableNotification]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send animated emoji that will display a random value to specified Telegram chat.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$emoji = 'basketball'
Send-TelegramDice -BotToken $botToken -ChatID $chat -Emoji $emoji
```

Sends animated basketball emoji that displays a random value via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$emoji = 'dice'
$sendTelegramDiceSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    DisableNotification = $true
    Verbose             = $true
    Emoji               = $emoji
}
Send-TelegramDice @sendTelegramDiceSplat
```

Sends animated dice emoji that displays a random value via Telegram API

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

### -Emoji
Emoji on which the dice throw animation is based.

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

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramDice.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramDice.md)

[https://core.telegram.org/bots/api#senddice](https://core.telegram.org/bots/api#senddice)

