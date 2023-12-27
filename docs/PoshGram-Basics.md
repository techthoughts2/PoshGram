# PoshGram - The Basics

## Getting Started with PoshGram

To use PoshGram, you first need to install it from the PowerShell Gallery using the following command:

```powershell
Install-Module -Name PoshGram -Repository PSGallery -Scope CurrentUser
```

## Messages

```powershell
Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"
```

### Formatting

#### HTML Formatting

```powershell
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$message = 'This is how to use:
    <b>bold</b>,
    <i>italic</i>,
    <u>underline</u>,
    <s>strikethrough</s>,
    <tg-spoiler>spoiler</tg-spoiler>,
    <a href="http://www.example.com/">inline URL</a>,
    <code>inline fixed-width code</code>,
    <pre>pre-formatted fixed-width code block</pre>,
    with default HTML formatting.'
$sendTelegramTextMessageSplat = @{
    BotToken = $botToken
    ChatID   = $chat
    Message  = $message
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

#### Markdown Formatting

```powershell
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$message = 'This is how to use:
    *bold*,
    _italic_,
    __underline__,
    ~strikethrough~,
    ||spoiler||,
    [inline URL](http://www.example.com/),
    `inline fixed-width code`,
    with MarkdownV2 style formatting'
$sendTelegramTextMessageSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    Message   = $message
    ParseMode = 'MarkdownV2'
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```
