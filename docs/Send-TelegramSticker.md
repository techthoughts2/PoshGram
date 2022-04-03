---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md
schema: 2.0.0
---

# Send-TelegramSticker

## SYNOPSIS
Sends Telegram sticker message via Bot API by file_id or sticker pack emoji.

## SYNTAX

### FileEmojiG
```
Send-TelegramSticker [-BotToken <String>] [-ChatID <String>] [-StickerSetName <String>] [-Shortcode <String>]
 [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

### FileIDG
```
Send-TelegramSticker [-BotToken <String>] [-ChatID <String>] [-FileID <String>] [-DisableNotification]
 [-ProtectContent] [<CommonParameters>]
```

### ByFileID
```
Send-TelegramSticker -BotToken <String> -ChatID <String> -FileID <String> [-DisableNotification]
 [-ProtectContent] [<CommonParameters>]
```

### BySPShortCode
```
Send-TelegramSticker -BotToken <String> -ChatID <String> -StickerSetName <String> -Shortcode <String>
 [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send sticker message to specified Telegram chat.
The file_id can be specified if you know it.
Use Get-TelegramStickerPackInfo if you do not already know the file_id of the sticker.
Alternatively you can specify the sticker pack name and an emoji shortcode.
This function will make an attempt to find the sticker that corresponds with the specified emoji.
See notes for details.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
Send-TelegramSticker -BotToken $botToken -ChatID $chat -FileID $sticker
```

Sends sticker message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
$sendTelegramStickerSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    FileID              = $sticker
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramSticker @sendTelegramStickerSplat
```

Sends sticker message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
Send-TelegramSticker -BotToken $botToken -ChatID $chat -StickerSetName STPicard -Shortcode ':slightly_smiling_face:'
```

Sends sticker message via Telegram API

### EXAMPLE 4
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$sendTelegramStickerSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    StickerSetName      = 'STPicard'
    Shortcode           = ':slightly_smiling_face:'
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramSticker @sendTelegramStickerSplat
```

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

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

Sticker packs are controlled by their author
    Not every sticker has a corresponding emoji
    Some sticker authors have the same emoji linked to multiple stickers
This function will make a best attempt to look up the sticker pack you specify and send a sticker that matches the corresponding emoji shortcode.

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramSticker.md)

[https://core.telegram.org/bots/api#sendsticker](https://core.telegram.org/bots/api#sendsticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

