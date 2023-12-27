# Telegram Bot API

TBD

## Telegram Bot API Key

TBD

   Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

### How to get a Telegram Bot API Key

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
