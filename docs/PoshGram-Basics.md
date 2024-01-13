# PoshGram - The Basics

## Getting Started with PoshGram

To use PoshGram, you first need to install it from the PowerShell Gallery using the following command:

```powershell
Install-Module -Name PoshGram -Repository PSGallery -Scope CurrentUser
```

## Overview

Be sure to set your Bot Token and Chat ID before running PoshGram functions:

```powershell
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
```

Nearly all functions support the following parameters:

- `DisableNotification` - Send the message silently. Users will receive a notification with no sound.
- `ProtectContent` - Protects the contents of the sent message from forwarding and saving.

## Token Test

```powershell
Test-BotToken -BotToken $botToken

  ok result
  -- ------
True @{id=111111111; is_bot=True; first_name=botname; username=botname_bot; can_join_groups=True; can_read_all_group_messages=False; supports_inline_queries=False}
```

## Messages

```powershell
Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message 'Hello'
```

### Formatting

#### HTML Formatting (*Default*)

```powershell
$message = 'This is how to use:
<b>bold</b>,
<i>italic</i>,
<u>underline</u>,
<s>strikethrough</s>,
<tg-spoiler>spoiler</tg-spoiler>,
<a href="http://www.example.com/">inline URL</a>,
<code>inline fixed-width code</code>,
<pre>pre-formatted fixed-width code block</pre>,
<pre><code class="language-powershell">#pre-formatted fixed-width code block written in the PowerShell programming language</code></pre>
<blockquote>Block quotation started\nBlock quotation continued\nThe last line of the block quotation</blockquote>
with default HTML formatting.'
$sendTelegramTextMessageSplat = @{
    BotToken = $botToken
    ChatID   = $chatID
    Message  = $message
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

#### Markdown Formatting

````powershell
$message = 'This is how to use:
*bold*,
_italic_,
__underline__,
~strikethrough~,
||spoiler||,
[inline URL](http://www.example.com/),
`inline fixed-width code`,
```
pre-formatted fixed-width code block
```
```powershell
# pre-formatted fixed-width code block written in PowerShell
```
>Block quotation started
>Block quotation continued
>The last line of the block quotation
with MarkdownV2 style formatting'
$sendTelegramTextMessageSplat = @{
    BotToken  = $botToken
    ChatID    = $chatID
    Message   = $message
    ParseMode = 'MarkdownV2'
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
````

## Contact

```powershell
$phone = '1-222-222-2222'
$firstName = 'Jean-Luc'
Send-TelegramContact -BotToken $botToken -ChatID $chatID -PhoneNumber $phone -FirstName $firstName
```

## Dice

'dice', 'dart', 'basketball', 'football', 'slotmachine', 'bowling'

```powershell
$emoji = 'basketball'
Send-TelegramDice -BotToken $botToken -ChatID $chatID -Emoji $emoji
```

## Polls

### Poll

```powershell
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
    'Star Trek: Prodigy'
    'Star Trek: Strange New Worlds'
)
Send-TelegramPoll -BotToken $botToken -ChatID $chatID -Question $question -Options $opt
```

### Quiz

```powershell
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
    BotToken             = $botToken
    ChatID               = $chatID
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

## Location

```powershell
$latitude = 37.621313
$longitude = -122.378955
Send-TelegramLocation -BotToken $botToken -ChatID $chatID -Latitude $latitude -Longitude $longitude
```

## Venue

```powershell
$latitude = 37.621313
$longitude = -122.378955
$title = 'Star Fleet Headquarters'
$address = 'San Francisco, CA 94128'
Send-TelegramVenue -BotToken $botToken -ChatID $chatID -Latitude $latitude -Longitude $longitude -Title $title -Address $address
```

## Media

### Media Group

*Note: This function only supports sending one media type per send (Photo | Video | Documents | Audio).*

```powershell
$sendTelegramMediaGroupSplat = @{
    BotToken  = $botToken
    ChatID    = $chatID
    MediaType = 'Photo'
    FilePaths = 'C:\photo\photo1.jpg', 'C:\photo\photo2.jpg'
}
Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
```

### Animation

```powershell
$animation = 'C:\animation\animation.gif'
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chatID -AnimationPath $animation
```

```powershell
$animationURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/jean.gif'
Send-TelegramURLAnimation -BotToken $botToken -ChatID $chatID -AnimationURL $animationURL
```

### Document

```powershell
$file = 'C:\Logs\Log1.txt'
Send-TelegramLocalDocument -BotToken $botToken -ChatID $chatID -File $file
```

```powershell
$fileURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/LogExample.zip'
Send-TelegramURLDocument -BotToken $botToken -ChatID $chatID -FileURL $fileURL
```

### Photo

```powershell
$photo = 'C:\photos\aphoto.jpg'
Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chatID -PhotoPath $photo
```

```powershell
$photoURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
Send-TelegramURLPhoto -BotToken $botToken -ChatID $chatID -PhotoURL $photourl
```

### Video

```powershell
$file = 'C:\videos\video.mp4'
Send-TelegramLocalVideo -BotToken $botToken -ChatID $chatID -Video $video
```

```powershell
$videourl = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Intro.mp4'
Send-TelegramURLVideo -BotToken $botToken -ChatID $chatID -VideoURL $videourl
```
