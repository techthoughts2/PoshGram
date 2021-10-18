---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocation.md
schema: 2.0.0
---

# Send-TelegramLocation

## SYNOPSIS
Sends Telegram location to indicate point on map

## SYNTAX

```
Send-TelegramLocation [-BotToken] <String> [-ChatID] <String> [-Latitude] <Single> [-Longitude] <Single>
 [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send latitude and longitude points on map to specified Telegram chat.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$latitude = 37.621313
$longitude = -122.378955
Send-TelegramLocation -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude
```

Sends location via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photo = 'C:\photos\aphoto.jpg'
$sendTelegramLocationSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    Latitude            = $latitude
    Longitude           = $longitude
    DisableNotification = $true
    Verbose             = $true
}
Send-TelegramLocation @sendTelegramLocationSplat
```

Sends location via Telegram API

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
Latitude of the location

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
Longitude of the location

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
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocation.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocation.md)

[https://core.telegram.org/bots/api#sendlocation](https://core.telegram.org/bots/api#sendlocation)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

