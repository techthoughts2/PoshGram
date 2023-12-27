---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Test-BotToken
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
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
Test-BotToken -BotToken $botToken
```

Validates the specified Bot auth token via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
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

### System.Management.Automation.PSCustomObject
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Test-BotToken](https://poshgram.readthedocs.io/en/latest/Test-BotToken)

[https://core.telegram.org/bots/api#getme](https://core.telegram.org/bots/api#getme)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

