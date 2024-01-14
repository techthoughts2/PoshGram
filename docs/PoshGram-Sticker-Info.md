# PoshGram Stickers

## Sending Stickers

There are ***four ways*** to send stickers to Telegram using PoshGram:

### 1 - **Send-TelegramLocalSticker**

This sends a locally sourced sticker (`.WEBP`/`.TGS`)

```powershell
$sticker = 'C:\stickers\sticker.webp'
Send-TelegramLocalSticker -BotToken $botToken -ChatID $chatID -StickerPath $sticker
```

### 2 - **Send-TelegramURLSticker**

This sends a sticker (`.WEBP`/`.TGS`) located at a specified URL

```powershell
$stickerURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.webp'
Send-TelegramURLSticker -BotToken $botToken -ChatID $chatID -StickerURL $stickerURL
```

### 3 - **Send-TelegramSticker** by file_id

You already know the file_id of the sticker you want to send

```powershell
$sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
Send-TelegramSticker -BotToken $botToken -ChatID $chatID -FileID $sticker
```

If you *do not know* the file_id, you can leverage [Get-TelegramStickerPackInfo](#getting-sticker-info) to determine that information.

### 4 - **Send-TelegramSticker** by Sticker pack name + emoji shortcode

Via this method you can provide the name of the sticker pack.

- *Ex. STPicard*
- *Ex. FriendlyFelines*

You also provide the emoji shortcode of the emoji you are trying to convey.

- *Ex. ':<zero-width space>slightly_smiling_face:'*
- *Ex. ':<zero-width space>grinning:'*

**Notes around this method:**

- Sticker packs are controlled by their *author*
    - Not every sticker has a corresponding emoji
    - Some sticker authors have the same emoji linked to multiple stickers
- This method will make a best attempt to look up the sticker pack you specify and send a sticker that matches the corresponding emoji shortcode.

If you don't want to have a *best attempt* scenario, use ***Get-TelegramStickerPackInfo*** to determine the exact file_id's from the sticker pack you'd like to send.

```powershell
Send-TelegramSticker -BotToken $botToken -ChatID $chatID -StickerSetName STPicard -Shortcode ':slightly_smiling_face:'
```

## Getting sticker info

To find the name of a sticker pack use the telegram app to share the sticker pack. This will provide a link which contains the sticker pack name.

![Telegram view sticker set](assets/telegram_view_sticker_set.png "View sticker set info") ![Telegram share stickers](assets/telegram_share_stickers.png "Share sticker button")

The share button produces the link: `https://t.me/addstickers/FriendlyFelines` which means the sticker pack name is `FriendlyFelines`.

Armed with this sticker pack information can now be retrieved:

```powershell
Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName 'FriendlyFelines'

width             : 512
height            : 512
emoji             : 🤔
set_name          : FriendlyFelines
is_animated       : False
is_video          : False
type              : regular
thumbnail         : @{file_id=AAMCAQADFQABZaLOfbzhrKnyovJStplqc2mjli4AAgEAA5RF2x1XpRoi4-PdMgEAB20AAzQE;
                    file_unique_id=AQADAQADlEXbHXI; file_size=3970; width=128; height=128}
thumb             : @{file_id=AAMCAQADFQABZaLOfbzhrKnyovJStplqc2mjli4AAgEAA5RF2x1XpRoi4-PdMgEAB20AAzQE;
                    file_unique_id=AQADAQADlEXbHXI; file_size=3970; width=128; height=128}
file_id           : CAACAgEAAxUAAWWizn284ayp8qLyUraZanNpo5YuAAIBAAOURdsdV6UaIuPj3TI0BA
file_unique_id    : AgADAQADlEXbHQ
file_size         : 19114
Group             : Smileys & Emotion
SubGroup          : face-hand
Code              : {U+1F914}
pwshEscapedFormat : `u{1F914}
Shortcode         : :thinking_face:

width             : 512
height            : 512
emoji             : 😀
set_name          : FriendlyFelines
is_animated       : False
is_video          : False
type              : regular
thumbnail         : @{file_id=AAMCAQADFQABZaLOfUVXweUZOYbANGa1sCGQJhwAAgIAA5RF2x3Sz_hda9kofAEAB20AAzQE;
                    file_unique_id=AQADAgADlEXbHXI; file_size=3088; width=128; height=128}
thumb             : @{file_id=AAMCAQADFQABZaLOfUVXweUZOYbANGa1sCGQJhwAAgIAA5RF2x3Sz_hda9kofAEAB20AAzQE;
                    file_unique_id=AQADAgADlEXbHXI; file_size=3088; width=128; height=128}
file_id           : CAACAgEAAxUAAWWizn1FV8HlGTmGwDRmtbAhkCYcAAICAAOURdsd0s_4XWvZKHw0BA
file_unique_id    : AgADAgADlEXbHQ
file_size         : 16266
Group             : Smileys & Emotion
SubGroup          : face-smiling
Code              : {U+1F600}
pwshEscapedFormat : `u{1F600}
Shortcode         : :grinning_face:

width          : 512
height         : 512
emoji          : ☕️
set_name       : FriendlyFelines
is_animated    : False
is_video       : False
type           : regular
thumbnail      : @{file_id=AAMCAQADFQABZaLOfR4rbWm5dZ2cnk42MapGQ9UAAgMAA5RF2x0pAAHlLv8qwoUBAAdtAAM0BA;
                 file_unique_id=AQADAwADlEXbHXI; file_size=5384; width=128; height=128}
thumb          : @{file_id=AAMCAQADFQABZaLOfR4rbWm5dZ2cnk42MapGQ9UAAgMAA5RF2x0pAAHlLv8qwoUBAAdtAAM0BA;
                 file_unique_id=AQADAwADlEXbHXI; file_size=5384; width=128; height=128}
file_id        : CAACAgEAAxUAAWWizn0eK21puXWdnJ5ONjGqRkPVAAIDAAOURdsdKQAB5S7_KsKFNAQ
file_unique_id : AgADAwADlEXbHQ
file_size      : 34292

width             : 512
height            : 512
emoji             : ❤️
set_name          : FriendlyFelines
is_animated       : False
is_video          : False
type              : regular
thumbnail         : @{file_id=AAMCAQADFQABZaLOfZL_Q75VmYJexqL5MxFEAAHPAAIEAAOURdsdQpHOkCCTahcBAAdtAAM0BA;
                    file_unique_id=AQADBAADlEXbHXI; file_size=3670; width=128; height=128}
thumb             : @{file_id=AAMCAQADFQABZaLOfZL_Q75VmYJexqL5MxFEAAHPAAIEAAOURdsdQpHOkCCTahcBAAdtAAM0BA;
                    file_unique_id=AQADBAADlEXbHXI; file_size=3670; width=128; height=128}
file_id           : CAACAgEAAxUAAWWizn2S_0O-VZmCXsai-TMRRAABzwACBAADlEXbHUKRzpAgk2oXNAQ
file_unique_id    : AgADBAADlEXbHQ
file_size         : 20398
Group             : Smileys & Emotion
SubGroup          : heart
Code              : {U+2764, U+FE0F}
pwshEscapedFormat : `u{2764}`u{FE0F}
Shortcode         : :red_heart:

width             : 512
height            : 512
emoji             : 🤤
set_name          : FriendlyFelines
is_animated       : False
is_video          : False
type              : regular
thumbnail         : @{file_id=AAMCAQADFQABZaLOfZqPEkLzZZEpOYG8-PsNT3QAAgUAA5RF2x0qZsIzvDWrLgEAB20AAzQE;
                    file_unique_id=AQADBQADlEXbHXI; file_size=4070; width=128; height=128}
thumb             : @{file_id=AAMCAQADFQABZaLOfZqPEkLzZZEpOYG8-PsNT3QAAgUAA5RF2x0qZsIzvDWrLgEAB20AAzQE;
                    file_unique_id=AQADBQADlEXbHXI; file_size=4070; width=128; height=128}
file_id           : CAACAgEAAxUAAWWizn2ajxJC82WRKTmBvPj7DU90AAIFAAOURdsdKmbCM7w1qy40BA
file_unique_id    : AgADBQADlEXbHQ
file_size         : 21948
Group             : Smileys & Emotion
SubGroup          : face-sleepy
Code              : {U+1F924}
pwshEscapedFormat : `u{1F924}
Shortcode         : :drooling_face:

width             : 512
height            : 512
emoji             : 🙃
set_name          : FriendlyFelines
is_animated       : False
is_video          : False
type              : regular
thumbnail         : @{file_id=AAMCAQADFQABZaLOfbANz7R80foGUum0cfg_k8EAAgYAA5RF2x0NT-731Ay-KQEAB20AAzQE;
                    file_unique_id=AQADBgADlEXbHXI; file_size=4830; width=128; height=128}
thumb             : @{file_id=AAMCAQADFQABZaLOfbANz7R80foGUum0cfg_k8EAAgYAA5RF2x0NT-731Ay-KQEAB20AAzQE;
                    file_unique_id=AQADBgADlEXbHXI; file_size=4830; width=128; height=128}
file_id           : CAACAgEAAxUAAWWizn2wDc-0fNH6BlLptHH4P5PBAAIGAAOURdsdDU_u99QMvik0BA
file_unique_id    : AgADBgADlEXbHQ
file_size         : 23118
Group             : Smileys & Emotion
SubGroup          : face-smiling
Code              : {U+1F643}
pwshEscapedFormat : `u{1F643}
Shortcode         : :upside-down_face:
```
