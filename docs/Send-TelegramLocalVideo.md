---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md
schema: 2.0.0
---

# Send-TelegramLocalVideo

## SYNOPSIS
Sends Telegram video message via Bot API from locally sourced file

## SYNTAX

```
Send-TelegramLocalVideo [-BotToken] <String> [-ChatID] <String> [-Video] <String> [[-Duration] <Int32>]
 [[-Width] <Int32>] [[-Height] <Int32>] [[-Caption] <String>] [[-ParseMode] <String>] [-Streaming]
 [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send video message to specified Telegram chat.
The video will be sourced from the local device and uploaded to telegram.
Several options can be specified to adjust message parameters.
Telegram only supports mp4 videos.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$file = "C:\videos\video.mp4"
Send-TelegramLocalVideo -BotToken $botToken -ChatID $chat -Video $video

Sends video message via Telegram API

### EXAMPLE 2
```
$botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

$chat = "-#########"
$video = "C:\videos\video.mp4"
Send-TelegramLocalVideo \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -Video $video \`
    -Duration 10 \`
    -Width 250 \`
    -Height 250 \`
    -Caption "Check out this video" \`
    -ParseMode Markdown \`
    -Streaming \`
    -DisableNotification \`
    -Verbose

Sends video message via Telegram API

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

### -Video
Local path to video file

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

### -Duration
Duration of sent video in seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Video width

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Height
Video height

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

### -Caption
Brief title or explanation for media

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

### -ParseMode
Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
Default is Markdown.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: Markdown
Accept pipeline input: False
Accept wildcard characters: False
```

### -Streaming
Use if the uploaded video is suitable for streaming

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
This works with PowerShell Version: 6.1+

Telegram clients support mp4 videos (other formats may be sent as Document)
Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md)

[https://core.telegram.org/bots/api#sendvideo](https://core.telegram.org/bots/api#sendvideo)

