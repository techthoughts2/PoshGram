---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md
schema: 2.0.0
---

# Test-BotToken

## SYNOPSIS
Validates Bot auth Token

## SYNTAX

```
Test-BotToken [-BotToken] <String> [<CommonParameters>]
```

## DESCRIPTION
A simple method for testing your bot's auth token.
Requires no parameters.
Returns basic information about the bot in form of a User object.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
Test-BotToken -BotToken $botToken
```

Validates the specified Bot auth token via Telegram API

### EXAMPLE 2
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$testBotTokenSplat = @{
    BotToken = $botToken
    Verbose  = $true
}
Test-BotToken @testBotTokenSplat
```

Validates the specified Bot auth token via Telegram API

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject (if successful)
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
This works with PowerShell Versions: 5.1, 6.0, 6.1
For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md)

[https://core.telegram.org/bots/api#getme](https://core.telegram.org/bots/api#getme)

