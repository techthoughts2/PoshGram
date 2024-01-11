---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramContact
schema: 2.0.0
---

# Send-TelegramContact

## SYNOPSIS
Sends Telegram phone contact message via BOT API.

## SYNTAX

```
Send-TelegramContact [-BotToken] <String> [-ChatID] <String> [-PhoneNumber] <String> [-FirstName] <String>
 [[-LastName] <String>] [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send contact information to specified Telegram chat.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$phone = '1-222-222-2222'
$firstName = 'Jean-Luc'
Send-TelegramContact -BotToken $botToken -ChatID $chat -PhoneNumber $phone -FirstName $firstName
```

Sends contact via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$phone = '1-222-222-2222'
$firstName = 'Jean-Luc'
$lastName = 'Picard'
$sendTelegramContactSplat = @{
    BotToken            = $botToken
    ChatID              = $chatID
    PhoneNumber         = $phone
    FirstName           = $firstName
    LastName            = $lastName
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramContact @sendTelegramContactSplat
```

Sends contact via Telegram API

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

### -PhoneNumber
Contact phone number

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

### -FirstName
Contact first name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastName
Contact last name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramContact](https://poshgram.readthedocs.io/en/latest/Send-TelegramContact)

[https://core.telegram.org/bots/api#sendcontact](https://core.telegram.org/bots/api#sendcontact)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

