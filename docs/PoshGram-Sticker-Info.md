# Send stickers using PoshGram

*How can I use PoshGram to get my bot to send stickers?*

## 4 ways to send stickers

### 1 - Send-TelegramLocalSticker

* This sends a locally sourced sticker (.WEBP/.TGS)
* ```Send-TelegramLocalSticker -BotToken $botToken -ChatID $chat -StickerPath $sticker```

### 2 - **Send-TelegramURLSticker**

* This sends a sticker (.WEBP/.TGS) located at a specified URL
* ```Send-TelegramURLSticker -BotToken $token -ChatID $channel -StickerURL $StickerURL```

### 3 - **Send-TelegramSticker** by file_id

* You already know the file_id of the sticker you want to send
* ```Send-TelegramSticker -BotToken $botToken -ChatID $chat -FileID $sticker```
  * If you *do not know* the file_id, you can leverage ***Get-TelegramStickerPackInfo*** to determine that information:
    * ```Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName STPicard```

### 4 - **Send-TelegramSticker** by Sticker pack name + emoji shortcode

Via this method you can provide the name of the sticker pack.

* *Ex. STPicard*
* *Ex. CookieMonster*

You also provide the emoji shortcode of the emoji you are trying to convey.

* *Ex. ':<zero-width space>slightly_smiling_face:'*
* *Ex. ':<zero-width space>grinning:'*

**Notes around this method:**

* Sticker packs are controlled by their *author*
  * Not every sticker has a corresponding emoji
  * Some sticker authors have the same emoji linked to multiple stickers
* This method will make a best attempt to look up the sticker pack you specify and send a sticker that matches the corresponding emoji shortcode.

If you don't want to have a *best attempt* scenario, use ***Get-TelegramStickerPackInfo*** to determine the exact file_id's from the sticker pack you'd like to send.