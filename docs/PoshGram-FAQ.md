# PoshGram - FAQ

- [PoshGram - FAQ](#poshgram---faq)
  - [FAQs](#faqs)
    - [I want to start using this, but how do I create a Telegram Bot and get a token?](#i-want-to-start-using-this-but-how-do-i-create-a-telegram-bot-and-get-a-token)
    - [How do I determine my chat ID number?](#how-do-i-determine-my-chat-id-number)
      - [Preferred Method](#preferred-method)
      - [Alternative method](#alternative-method)
    - [How can I use PoshGram to have my bot send stickers?](#how-can-i-use-poshgram-to-have-my-bot-send-stickers)
    - [How can I use PoshGram to send inline Emojis?](#how-can-i-use-poshgram-to-send-inline-emojis)
      - [Method 1](#method-1)
      - [Method 2](#method-2)
      - [Method 3](#method-3)
    - [How can I send properly formed keyboards?](#how-can-i-send-properly-formed-keyboards)
      - [Inline Keyboard Example](#inline-keyboard-example)
      - [Custom Keyboard Example](#custom-keyboard-example)
    - [Why does PoshGram only support higher versions of PowerShell?](#why-does-poshgram-only-support-higher-versions-of-powershell)
    - [Are there any restrictions when using PoshGram?](#are-there-any-restrictions-when-using-poshgram)

## FAQs

### I want to start using this, but how do I create a Telegram Bot and get a token?

- To learn how to create and set up a bot:
  - [TechThoughts video on how to make a Telegram Bot](https://youtu.be/UhZtrhV7t3U)
  - [Introduction to Bots](https://core.telegram.org/bots)
  - [Bot FAQ](https://core.telegram.org/bots/faq)
  - [BotFather](https://t.me/BotFather)

### How do I determine my chat ID number?

*I've got a bot setup, and I have a token, but how do I determine my chat ID number (also referred to as the channel ID)?*

#### Preferred Method

The easiest way is to login to the [Telegram Web Client](https://web.telegram.org/#/login) and find your channel on the left. When you select it the address in your URL bar will change.

- Copy the channel ID in your browser's address bar
  - It will look something like this:
    - ```#/im?p=g112345678```
  - *Just copy the numbers after **g*- and make sure to include the (-) before the channel number*
    - Ex ```-#########```
    - Ex from above would be: ```-112345678```

#### Alternative method

Forward a message from your channel to the getidsbot [https://telegram.me/getidsbot](https://telegram.me/getidsbot)

### How can I use PoshGram to have my bot send stickers?

[PoshGram-Sticker-Info](docs/PoshGram-Sticker-Info.md)

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
1. Convert it to HTML hexadicimal
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
    & 'C:\Program Files\PowerShell\6\pwsh.exe' -command { Import-Module PoshGram;$token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chat = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $token -ChatID $chat -Message "Test from 5.1 calling 6.1 to send Telegram Message via PoshGram" }
    ```

### Are there any restrictions when using PoshGram?

- Bots can currently send files of up to 50 MB in size
- Certain functions are limited to certain file extensions, see each function's documentation for more information
