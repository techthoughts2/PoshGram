---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md
schema: 2.0.0
---

# Send-TelegramSticker

## SYNOPSIS
Sends Telegram text message via Bot API

## SYNTAX

### FileEmojiG
```
Send-TelegramSticker [-BotToken <String>] [-ChatID <String>] [-StickerSetName <String>] [-Shortcode <String>]
 [-DisableNotification] [<CommonParameters>]
```

### FileIDG
```
Send-TelegramSticker [-BotToken <String>] [-ChatID <String>] [-FileID <String>] [-DisableNotification]
 [<CommonParameters>]
```

### ByFileID
```
Send-TelegramSticker -BotToken <String> -ChatID <String> -FileID <String> [-DisableNotification]
 [<CommonParameters>]
```

### BySPShortCode
```
Send-TelegramSticker -BotToken <String> -ChatID <String> -StickerSetName <String> -Shortcode <String>
 [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send text message to specified Telegram chat.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
Send-TelegramSticker -BotToken $botToken -ChatID $chat -FileID $sticker

Sends sticker message via Telegram API

### EXAMPLE 2
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
Send-TelegramSticker \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -FileID $sticker \`
    -DisableNotification \`
    -Verbose

Sends sticker message via Telegram API

### EXAMPLE 3
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
Send-TelegramSticker -BotToken $botToken -ChatID $chat -StickerSetName STPicard -Shortcode ':slightly_smiling_face:'

Sends sticker message via Telegram API
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-#########"
Send-TelegramSticker \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -StickerSetName STPicard \`
    -Shortcode ':slightly_smiling_face:' \`
    -DisableNotification \`
    -Verbose

Sends sticker message via Telegram API

## PARAMETERS

### -BotToken
Use this token to access the HTTP API

```yaml
Type: String
Parameter Sets: FileEmojiG, FileIDG
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ByFileID, BySPShortCode
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChatID
Unique identifier for the target chat

```yaml
Type: String
Parameter Sets: FileEmojiG, FileIDG
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ByFileID, BySPShortCode
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileID
Telegram sticker file_id
If you do not know the file ID of a sticker, you can use Get-TelegramStickerPackInfo to determine it.

```yaml
Type: String
Parameter Sets: FileIDG
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ByFileID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StickerSetName
Name of the sticker set

```yaml
Type: String
Parameter Sets: FileEmojiG
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: BySPShortCode
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Shortcode
Emoji shortcode

```yaml
Type: String
Parameter Sets: FileEmojiG
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: BySPShortCode
Aliases:

Required: True
Position: Named
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
This works with PowerShell Versions: 5.1, 6.0, 6.1+
For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md)

[https://core.telegram.org/bots/api#sendsticker](https://core.telegram.org/bots/api#sendsticker)

