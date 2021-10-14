---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md
schema: 2.0.0
---

# Send-TelegramLocalAudio

## SYNOPSIS
Sends Telegram audio message via Bot API from locally sourced file

## SYNTAX

```
Send-TelegramLocalAudio [-BotToken] <String> [-ChatID] <String> [-Audio] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [[-Duration] <Int32>] [[-Performer] <String>] [[-Title] <String>]
 [[-FileName] <String>] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send audio message to specified Telegram chat.
The audio will be sourced from the local device and uploaded to telegram.
Several options can be specified to adjust message parameters.
Telegram only supports mp3 audio.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$audio = 'C:\audio\halo_on_fire.mp3'
Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio
```

Sends audio message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$audio = 'C:\audio\halo_on_fire.mp3'
$sendTelegramLocalAudioSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    Audio               = $audio
    Caption             = 'Check out this audio track'
    ParseMode           = 'MarkdownV2'
    Duration            = 495
    Performer           = 'Metallica'
    Title               = 'Halo On Fire'
    FileName            = 'halo_on_fire.mp3'
    DisableNotification = $true
    Verbose             = $true
}
Send-TelegramLocalAudio @sendTelegramLocalAudioSplat
```

Sends audio message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$audio = 'C:\audio\halo_on_fire.mp3'
$sendTelegramLocalAudioSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    Audio     = $audio
    Performer = 'Metallica'
    Title     = 'Halo On Fire'
    FileName  = 'halo_on_fire.mp3'
    Caption   = 'Check out this __awesome__ audio track\.'
    ParseMode = 'MarkdownV2'
}
Send-TelegramLocalAudio @sendTelegramLocalAudioSplat
```

Sends audio message via Telegram API with properly formatted underlined word and escaped special character.

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

### -Audio
Local path to audio file

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

### -Duration
Duration of the audio in seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Performer
Performer

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Track Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
Original File Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

### System.Management.Automation.PSCustomObject
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
This works with PowerShell Version: 6.1+

Your audio must be in the .mp3 format.
Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md)

[https://core.telegram.org/bots/api#sendaudio](https://core.telegram.org/bots/api#sendaudio)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

