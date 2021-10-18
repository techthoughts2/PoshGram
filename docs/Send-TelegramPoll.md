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

### default (Default)
```
Send-TelegramPoll -BotToken <String> -ChatID <String> -Question <String> -Options <String[]>
 [-IsAnonymous <Boolean>] [-PollType <String>] [-MultipleAnswers <Boolean>] [-QuizAnswer <Int32>]
 [-Explanation <String>] [-ExplanationParseMode <String>] [-DisableNotification] [<CommonParameters>]
```

### OpenPeriod
```
Send-TelegramPoll -BotToken <String> -ChatID <String> -Question <String> -Options <String[]>
 [-IsAnonymous <Boolean>] [-PollType <String>] [-MultipleAnswers <Boolean>] [-QuizAnswer <Int32>]
 [-Explanation <String>] [-ExplanationParseMode <String>] [-OpenPeriod <Int32>] [-DisableNotification]
 [<CommonParameters>]
```

### OpenDate
```
Send-TelegramPoll -BotToken <String> -ChatID <String> -Question <String> -Options <String[]>
 [-IsAnonymous <Boolean>] [-PollType <String>] [-MultipleAnswers <Boolean>] [-QuizAnswer <Int32>]
 [-Explanation <String>] [-ExplanationParseMode <String>] [-CloseDate <DateTime>] [-DisableNotification]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send a native poll with a question and several answer options.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$question = 'What is your favorite Star Trek series?'
$opt = @(
    'Star Trek: The Original Series',
    'Star Trek: The Animated Series',
    'Star Trek: The Next Generation',
    'Star Trek: Deep Space Nine',
    'Star Trek: Voyager',
    'Star Trek: Enterprise',
    'Star Trek: Discovery',
    'Star Trek: Picard',
    'Star Trek: Lower Decks'
)
Send-TelegramPoll -BotToken $botToken -ChatID $chat -Question $question -Options $opt
```

Sends poll via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$question = 'Who is your favorite Star Fleet Captain?'
$opt = 'Jean-Luc Picard','Jean-Luc Picard','Jean-Luc Picard'
$sendTelegramPollSplat = @{
    BotToken            = $token
    ChatID              = $chat
    Question            = $question
    Options             = $opt
    DisableNotification = $true
    IsAnonymous         = $true
    PollType            = 'regular'
    MultipleAnswers     = $false
}
Send-TelegramPoll @sendTelegramPollSplat
```

Sends poll via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$question = 'Who was the best Starfleet captain?'
$opt = @(
    'James Kirk',
    'Jean-Luc Picard',
    'Benjamin Sisko',
    'Kathryn Janeway',
    'Jonathan Archer'
)
$answer = 1
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

### EXAMPLE 4
```
$question = 'Which class is the largest starship constructed by Starfleet?'
$opt = @(
    'Constitution class',
    'Intrepid class',
    'California class',
    'Galaxy class',
    'Invincible class',
    'Sovereign class',
    'Excelsior class',
    'Miranda class',
    'Nebula class',
    'Olympic class'
)
$explanation = 'At 1,607.2 meters in length, 764.4 meters across, and 305.76 meters high, Invincible class is the largest starship class ever built by Starfleet.'
$answer = 4
$sendTelegramPollSplat = @{
    BotToken    = $token
    ChatID      = $channel
    Question    = $question
    Options     = $opt
    Explanation = $explanation
    IsAnonymous = $false
    PollType    = 'quiz'
    QuizAnswer  = $answer
}
Send-TelegramPoll @sendTelegramPollSplat
```

Sends quiz via Telegram API with answer explanation.

### EXAMPLE 5
```
$question = 'Which Star Trek captain has an artificial heart?'
$opt = @(
    'James Kirk',
    'Jean-Luc Picard',
    'Benjamin Sisko',
    'Kathryn Janeway',
    'Jonathan Archer'
)
$explanation = 'In _2327_, Jean\-Luc Picard received an *artificial heart* after he was stabbed by a Nausicaan during a bar brawl\.'
$answer = 1
$sendTelegramPollSplat = @{
    BotToken             = $token
    ChatID               = $channel
    Question             = $question
    Options              = $opt
    Explanation          = $explanation
    ExplanationParseMode = 'MarkdownV2'
    IsAnonymous          = $false
    PollType             = 'quiz'
    QuizAnswer           = $answer
    CloseDate            = (Get-Date).AddDays(1)
}
Send-TelegramPoll @sendTelegramPollSplat
```

Sends quiz via Telegram API with answer explanation properly formatted in MarkdownV2.
Quiz will be open for 24 hours (1 day).

## PARAMETERS

### -BotToken
Use this token to access the HTTP API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Explanation
Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExplanationParseMode
HTML vs Markdown for explanation formatting - HTML by default - https://core.telegram.org/bots/api#formatting-options

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: HTML
Accept pipeline input: False
Accept wildcard characters: False
```

### -OpenPeriod
Amount of time in seconds the poll will be active after creation, 5-600.

```yaml
Type: Int32
Parameter Sets: OpenPeriod
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CloseDate
Point in time (Unix timestamp) when the poll will be automatically closed.
Must be at least 5 and no more than 600 seconds in the future.

```yaml
Type: DateTime
Parameter Sets: OpenDate
Aliases:

Required: False
Position: Named
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

### System.Management.Automation.PSCustomObject
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

Telegram currently supports questions 1-300 characters
Telegram currently supports 2-10 options 1-100 characters each

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md)

[https://core.telegram.org/bots/api#sendpoll](https://core.telegram.org/bots/api#sendpoll)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

