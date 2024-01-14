---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramURLAudio
schema: 2.0.0
---

# Send-TelegramURLAudio

## SYNOPSIS
Sends Telegram audio message via Bot API from URL sourced file

## SYNTAX

```
Send-TelegramURLAudio [-BotToken] <String> [-ChatID] <String> [-AudioURL] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [[-Duration] <Int32>] [[-Performer] <String>] [[-Title] <String>]
 [[-FileName] <String>] [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send audio message to specified Telegram chat.
The file will be sourced from the provided URL and sent to Telegram.
Several options can be specified to adjust message parameters.
Only works for mp3 files.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$audioURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
Send-TelegramURLAudio -BotToken $botToken -ChatID $chatID -AudioURL $audioURL
```

Sends audio message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$audioURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
$sendTelegramURLAudioSplat = @{
    BotToken            = $botToken
    ChatID              = $chatID
    AudioURL            = $audioURL
    Caption             = 'Check out this audio track'
    ParseMode           = 'MarkdownV2'
    Duration            = 495
    Performer           = 'Metallica'
    Title               = 'Halo On Fire'
    FileName            = 'halo_on_fire.mp3'
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramURLAudio @sendTelegramURLAudioSplat
```

Sends audio message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$audioURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
$sendTelegramURLAudioSplat = @{
    BotToken            = $botToken
    ChatID              = $chatID
    AudioURL            = $audioURL
    Title               = 'Halo On Fire'
    FileName            = 'halo_on_fire.mp3'
    Performer           = 'Metallica'
    Caption             = 'Check out this __awesome__ audio track\.'
    ParseMode           = 'MarkdownV2'
}
Send-TelegramURLAudio @sendTelegramURLAudioSplat
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

### -AudioURL
URL path to audio file

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

Your audio must be in the .mp3 format.
Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramURLAudio](https://poshgram.readthedocs.io/en/latest/Send-TelegramURLAudio)

[https://core.telegram.org/bots/api#sendaudio](https://core.telegram.org/bots/api#sendaudio)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

