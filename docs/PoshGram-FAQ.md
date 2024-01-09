# PoshGram - FAQ

## FAQs

### I want to start using this, but how do I create a Telegram Bot and get a token?

TBD

### How can I use PoshGram to have my bot send stickers?

[PoshGram-Sticker-Info](docs/PoshGram-Sticker-Info.md)

### How can I properly engage formatting text in messages?

All message types that support text can have text formatted using HTML or MarkdownV2 styling:

#### HTML Style (*Default*)

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
with default HTML formatting.'

$sendTelegramTextMessageSplat = @{
    BotToken = $botToken
    ChatID   = $chat
    Message  = $message
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

#### MarkdownV2 style

```powershell
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

### How can I use PoshGram to send inline Emojis?

There isn't a super elegant way to send inline Emojis.

#### Method 1

1. Find the unicode of the desired emoji from the [Full Emoji List](https://emojipedia.org/)
1. Properly escape the unicode:
    - ````u{1F929}```
1. Send message with emoji

```powershell
##############################################
# Method 1
##############################################
# get the unicode of the desired emoji
# https://emojipedia.org/
# send message
Send-TelegramTextMessage -BotToken $token -ChatID $channel -Message "This is a star-struck face: `u{1F929}"
```

#### Method 2

1. Find the unicode of the desired emoji from the [Full Emoji List](https://unicode.org/emoji/charts/full-emoji-list.html)
1. Convert it to HTML hexadecimal
    - ```U+1F601  --> &#x1F601```
1. Send message with emoji

```powershell
##############################################
# Method 1
##############################################
# get the unicode of the desired emoji
# https://unicode.org/emoji/charts/full-emoji-list.html
$uniCodeEmoji = 'U+1F601'
# convert the unicode to a HTML hexadecimal reference
# U+1F601  --> &#x1F601
$hexEmoji = $uniCodeEmoji.Replace('U+','&#x')
# send message
Send-TelegramTextMessage -BotToken $token -ChatID $channel -Message "This is a smiley face: $hexEmoji"
```

#### Method 3

1. Send yourself an emoji message on telegram
1. Copy the emoji
1. Paste it into a PowerShell variable
1. Send message with emoji

```powershell
##############################################
# Method 2
##############################################
# send yourself an emoji telegram message with an emoji and copy it

# paste it into a variable
$emoji = '😔'
# send message
Send-TelegramTextMessage -BotToken $token -ChatID $channel -Message "This is a sad face: $emoji"
```

### How can I send properly formed keyboards?

The Telegram Bot API supports two types of keyboards:

- **Inline Keyboards**
    - ![Telegram Inline Keyboard](../media/telegram_inline_keyboard.png "Telegram Inline Keyboard example")
    - See [https://core.telegram.org/bots/api#inlinekeyboardbutton](inlinekeyboardbutton) for additional details for forming inline keyboards.
- **Custom Keyboards**
    - ![Telegram Custom Keyboard](../media/telegram_custom_keyboard.png "Telegram Custom Keyboard example")
    - See [https://core.telegram.org/bots/api#replykeyboardmarkup](replykeyboardmarkup) for additional details for forming custom keyboards.

Keyboards are formed using an *Array of Arrays*.

Essentially, the arrays represents rows and columns of keyboard buttons. See below for examples:

#### Inline Keyboard Example

```powershell
$inlineRow1 = @(
    @{
        text = "`u{1F517} Visit"
        url  = 'https://www.techthoughts.info'
    }
)
$inlineRow2 = @(
    @{
        text = "`u{1F4CC} Pin"
        url  = 'https://www.techthoughts.info/learn-powershell-series/'
    }
)
$inlineKeyboard = @{
    inline_keyboard = @(
        $inlineRow1,
        $inlineRow2
    )
}
$sendTelegramTextMessageSplat = @{
    BotToken = $botToken
    ChatID   = $chat
    Message  = 'Sending an example of inline keyboard'
    Keyboard = $inlineKeyboard
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

#### Custom Keyboard Example

```powershell
$row1 = @(
    @{
        text = "`u{1F513} Unlock"
    }
)
$row2 = @(
    @{
        text = "`u{1F512} Lock"
    }
)
$customKeyboard = @{
    keyboard          = @(
        $row1,
        $row2
    )
    one_time_keyboard = $true
    is_persistent     = $false
}
$sendTelegramTextMessageSplat = @{
    BotToken = $botToken
    ChatID   = $chat
    Message  = 'Sending an example of a custom keyboard'
    Keyboard = $customKeyboard
}
Send-TelegramTextMessage @sendTelegramTextMessageSplat
```

### Why does PoshGram only support higher versions of PowerShell?

- *Why is PowerShell 6.1.0 (or higher) required? - Why can't I use 5.1?*
    - For new files to be uploaded and sent to a chat via bot, Telegram requires the use of multipart/form-data. This is not natively supported in 5.1. It is available in 6.0.0, but requires the manual creation of the form. 6.1.0 introduces native form capabilities. Functions that reference a URL, or that only use messaging  (**Send-TelegramTextMessage**) are 5.1 compatible. However, you would have to pull these functions out separately if you are absolutely set on using 5.1

- *I don't want to use PowerShell 6.1.0 (or higher) because I primarily use 5.1 or lower*
    - Good news - PowerShell 6.1.0+ installs to a completely separate folder, has a completely different exe (pwsh.exe), and references a different module path. This means you can install it on any system and use PoshGram while continuing to use any other version of PowerShell
    - Here is an example of how you can call PS 6.1 and use PoshGram from older versions of PowerShell:

    ```powershell
    #here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram
    & 'C:\Program Files\PowerShell\6\pwsh.exe' -command { Import-Module PoshGram;$token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chatID = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 6.1 to send Telegram Message via PoshGram" }
    ```

### Are there any restrictions when using PoshGram?

- Bots can currently send files of up to 50 MB in size
- Certain functions are limited to certain file extensions, see each function's documentation for more information
