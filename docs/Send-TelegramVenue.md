---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramVenue.md
schema: 2.0.0
---

# Send-TelegramVenue

## SYNOPSIS
Sends Telegram information about a venue.

## SYNTAX

```
Send-TelegramVenue [-BotToken] <String> [-ChatID] <String> [-Latitude] <Single> [-Longitude] <Single>
 [-Title] <String> [-Address] <String> [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send latitude, longitude, title, and address information about a venue to specified Telegram chat.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$latitude = 37.621313
$longitude = -122.378955
$title = 'Star Fleet Headquarters'
$address = 'San Francisco, CA 94128'
Send-TelegramVenue -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude -Title $title -Address $address
```

Sends venue information via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$latitude = 37.621313
$longitude = -122.378955
$title = 'Star Fleet Headquarters'
$address = 'San Francisco, CA 94128'
$sendTelegramVenueSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    Latitude            = $latitude
    Longitude           = $longitude
    Title               = $title
    Address             = $address
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramVenue @sendTelegramVenueSplat
```

Sends venue information via Telegram API

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

### -Latitude
Latitude of the venue

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Longitude
Longitude of the venue

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Name of the venue

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Address
Address of the venue

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
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

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramVenue.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramVenue.md)

[https://core.telegram.org/bots/api#sendvenue](https://core.telegram.org/bots/api#sendvenue)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

