---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramContact.md
schema: 2.0.0
---

# Send-TelegramContact

## SYNOPSIS
Sends Telegram phone contact message via BOT API.

## SYNTAX

```
Send-TelegramContact [-BotToken] <String> [-ChatID] <String> [-PhoneNumber] <String> [-FirstName] <String>
 [[-LastName] <String>] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send contact information to specified Telegram chat.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$phone = '1-222-222-2222'
$firstName = 'Jean-Luc'
Send-TelegramContact -BotToken $botToken -ChatID $chat -PhoneNumber $phone -FirstName $firstName
```

Sends contact via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$phone = '1-222-222-2222'
$firstName = 'Jean-Luc'
$lastName = 'Picard'
$sendTelegramContactSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    PhoneNumber         = $phone
    FirstName           = $firstName
    LastName            = $lastName
    DisableNotification = $true
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject (if successful)
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
This works with PowerShell Version: 6.1+

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramContact.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramContact.md)

[https://core.telegram.org/bots/api#sendcontact](https://core.telegram.org/bots/api#sendcontact)

