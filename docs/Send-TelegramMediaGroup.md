---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramMediaGroup.md
schema: 2.0.0
---

# Send-TelegramMediaGroup

## SYNOPSIS
Sends Telegram a group of photos or videos as an album via Bot API from locally sourced media

## SYNTAX

```
Send-TelegramMediaGroup [-BotToken] <String> [-ChatID] <String> [-MediaType] <String> [[-FilePaths] <String[]>]
 [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send a group of photo or video as an album message to specified Telegram chat.
The media will be sourced from the local device and uploaded to telegram.
This function only supports sending one media type per send (Photo | Video).
2 files minimum and 10 files maximum are required for this function.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
Send-TelegramMediaGroup \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -MediaType Photo \`
    -FilePaths "C:\photo\photo1.jpg","C:\photo\photo2.jpg"
```


Uploads all provided photo files as album via Telegram Bot API.

### EXAMPLE 2
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
Send-TelegramMediaGroup \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -MediaType Photo \`
    -FilePaths (Get-ChildItem C:\PhotoGroup | Select-Object -ExpandProperty FullName)
```


Retrieves all photo file paths from C:\PhotoGroup and uploads as photo album.
Keep in mind that your location must have at least 2, but not more than 10 files.

### EXAMPLE 3
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
$vPath = 'C:\VideoGroup'
$vFiles = @(
    "$vPath\first_contact.mp4",
    "$vPath\root_beer.mp4"
)
Send-TelegramMediaGroup \`
    -BotToken $botToken \`
    -ChatID $chat \`
    -MediaType Video \`
    -FilePaths $vFiles \`
    -DisableNotification
```


Uploads all provided video files as album via Telegram Bot API.

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

### -MediaType
Type of media to send

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

### -FilePaths
List of filepaths for media you want to send

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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

The following photo types are supported:
JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

The following video types are supported:
Telegram clients support mp4 videos

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

?
This was really hard to make.

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramMediaGroup.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramMediaGroup.md)

[https://core.telegram.org/bots/api#sendmediagroup](https://core.telegram.org/bots/api#sendmediagroup)


