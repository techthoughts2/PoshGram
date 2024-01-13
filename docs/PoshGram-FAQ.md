# PoshGram - FAQ

## FAQs

### I want to start using this, but how do I create a Telegram Bot and get a token?

See [Setting Up Telegram Bot](PoshGram-Telegram-API.md)

### How do I determine what Chat ID my bot is a part of?

See [How do I determine my chat ID number?](PoshGram-Telegram-API.md#how-do-i-determine-my-chat-id-number)

### How can I use PoshGram to have my bot send stickers?

[PoshGram-Sticker-Info](PoshGram-Sticker-Info.md)

### How can I properly engage formatting text in messages?

- See [Message Formatting](PoshGram-Basics.md#formatting) for examples on how to use HTML and Markdown formatting in your messages.
- See [Escaping Characters](PoshGram-Advanced.md#escaping-characters) to properly escape characters in your messages.

### How can I use PoshGram to send inline Emojis?

See [Sending emojis](PoshGram-Advanced.md#sending-emojis).

### How can I send properly formed keyboards?

See [Sending keyboards](PoshGram-Advanced.md#keyboards).

### Why does PoshGram only support higher versions of PowerShell?

- *Why is PowerShell 6.1.0 (or higher) required? - Why can't I use 5.1?*
    - For new files to be uploaded and sent to a chat via bot, Telegram requires the use of multipart/form-data. This is not natively supported in 5.1. It is available in 6.0.0, but requires the manual creation of the form. 6.1.0 introduces native form capabilities. Functions that reference a URL, or that only use messaging  (**Send-TelegramTextMessage**) are 5.1 compatible. However, you would have to pull these functions out separately if you are absolutely set on using 5.1

- *I don't want to use PowerShell 6.1.0 (or higher) because I primarily use 5.1 or lower*
    - Good news - PowerShell 6.1.0+ installs to a completely separate folder, has a completely different exe (`pwsh.exe`), and references a different module path. This means you can install it on any system and use PoshGram while continuing to use any other version of PowerShell
    - Here are some examples of how you can call PS 6.1 and use PoshGram from older versions of PowerShell:

        ```powershell
        #here is an example of calling PowerShell 6.1+ from PowerShell 5.1 to send a Telegram message with PoshGram using dynamic variables in the message
        $botToken = “#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx”
        $chatID = “-#########”
        $test = "I am a test"
        & '.\Program Files\PowerShell\6\pwsh.exe' -command "& {Import-Module PoshGram;Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message '$test';}"
        #--------------------------------------------------------------------------
        #here is an example of calling PowerShell 7+ from PowerShell 5.1 to send a Telegram message with PoshGram
        & 'C:\Program Files\PowerShell\7\pwsh.exe' -command { Import-Module PoshGram;$botToken = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx';$chatID = '-nnnnnnnnn';Send-TelegramTextMessage -BotToken $botToken -ChatID $chatID -Message "Test from 5.1 calling 7+ to send Telegram Message via PoshGram" }
        ```

### Are there any restrictions when using PoshGram?

- Bots can currently send files of up to 50 MB in size
- Certain functions are limited to certain file extensions, see each function's documentation for more information
