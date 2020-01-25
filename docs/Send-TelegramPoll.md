---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md
schema: 2.0.0
---

# Send-TelegramPoll

## SYNOPSIS
Sends Telegram native poll.

## SYNTAX

```
Send-TelegramPoll [-BotToken] <String> [-ChatID] <String> [-Question] <String> [-Options] <String[]>
 [[-IsAnonymous] <Boolean>] [[-PollType] <String>] [[-MultipleAnswers] <Boolean>] [[-QuizAnswer] <Int32>]
 [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send a native poll with a question and several answer options.

## EXAMPLES

### EXAMPLE 1
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
$question = 'What is your favorite Star Trek series?'
$opt = @(
    'Star Trek: The Original Series',
    'Star Trek: The Animated Series',
    'Star Trek: The Next Generation',
    'Star Trek: Deep Space Nine',
    'Star Trek: Voyager',
    'Star Trek: Enterprise',
    'Star Trek: Discovery',
    'Star Trek: Picard'
)
Send-TelegramPoll -BotToken $botToken -ChatID $chat -Question $question -Options $opt
```

Sends poll via Telegram API

### EXAMPLE 2
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
$question = 'Who is your favorite Star Fleet Captain?'
$opt = 'Jean-Luc Picard','Jean-Luc Picard','Jean-Luc Picard'
Send-TelegramPoll `
    -BotToken $token `
    -ChatID $chat `
    -Question $question `
    -Options $opt `
    -DisableNotification `
    -IsAnonymous $true `
    -PollType 'regular `
    -MultipleAnswers $false
```

Sends poll via Telegram API

### EXAMPLE 3
```
$botToken = "nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$chat = "-nnnnnnnnn"
$question = 'Who was the best Starfleet captain?'
$opt = @(
    'James Kirk',
    'Jean-Luc Picard',
    'Benjamin Sisko',
    'Kathryn Janeway',
    'Jonathan Archer'
)
$answer = 2
$sendTelegramPollSplat = @{
    BotToken    = $botToken
    ChatID      = $chat
    Question    = $question
    Options     = $opt
    IsAnonymous = $false
    PollType    = 'quiz'
    QuizAnswer  = $answer
}
Send-TelegramPoll @sendTelegramPollSplat
```

Sends quiz via Telegram API

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

### -Question
Poll question

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

### -Options
String array of answer options

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsAnonymous
True, if the poll needs to be anonymous, defaults to True

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -PollType
Poll type, "quiz" or "regular", defaults to "regular"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Regular
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultipleAnswers
True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuizAnswer
0-based identifier of the correct answer option, required for polls in quiz mode

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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

### System.Management.Automation.PSCustomObject (if successful)
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
This works with PowerShell Version: 6.1+

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

Telegram currently supports questions 1-255 characters
Telegram currently supports 2-10 options 1-100 characters each

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md)

[https://core.telegram.org/bots/api#sendpoll](https://core.telegram.org/bots/api#sendpoll)

