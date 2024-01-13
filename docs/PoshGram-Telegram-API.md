# Setting Up Telegram Bot

PoshGram requires that you create a Bot and get its Bot ID token. You will also need to add your bot to a group or channel and retrieve the chat ID of that group.

## How to get a Telegram Bot API Key

Just message the [BotFather](https://t.me/BotFather) and follow the directions.

If you want more resources here are some links and a video guide below.

- To learn how to create and set up a bot:
    - Official Telegram Documentation
        - [How Do I Create a Bot?](https://core.telegram.org/bots#how-do-i-create-a-bot)
        - [Bot FAQ](https://core.telegram.org/bots/faq)
        - [Introduction to Bots](https://core.telegram.org/bots)
    - [TechThoughts video on how to make a Telegram Bot](https://youtu.be/UhZtrhV7t3U)

## How do I determine my chat ID number?

*I've got a bot setup, and I have a token, but how do I determine my chat ID number (also referred to as the channel ID)?*

### Preferred Method - Web Client

The easiest way is to login to the [Telegram Web Client](https://web.telegram.org/#/login) and find your channel on the left. When you select it the address in your URL bar will change.

1. Go to [(https://web.telegram.org](https://web.telegram.org/#/login)
2. Click on your channel
3. Look at the url, and copy the channel ID in your browser's address bar
    - It may look something like the below examples:
        - `#/im?p=g112345678`
        - `#-828938028`
    - *Just copy the ending numbers with no characters or symbols.*
4. Add a `-` to the front of your numbers to and this is your Chat ID number.
    - Ex `-#########`
    - Ex from above would be: `-112345678`

### Message Method

Send your bot a message and then retrieve your bot's `getUpdates` which contains your chat ID.

1. Go to your channel
2. Message your bot. *Note: your bot needs to be a member of the channel for this method to work*
    - In this example I message the `@poshgram_bot`
        - `/my_id @yourbot_bot`
3. Retrieve the `getUpdates` for your bot using its token

    ```powershell
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $Updates = Invoke-WebRequest -Uri "https://api.telegram.org/bot$botToken/getUpdates"
    $objUpdates = ConvertFrom-Json $Updates.Content
    $objUpdates.result.message.chat.id
    ```
