<#
.SYNOPSIS
    Enriches the Telegram sticker object with additional emoji data.
.DESCRIPTION
    Evaluates the emoji data for the specified emoji and adds it to the Telegram sticker object.
.EXAMPLE
    Add-EmojiDetail -StickerObject $stickerObject

    Enriches the Telegram sticker object with additional emoji data.
.PARAMETER StickerObject
    Telegram sticker object
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
.COMPONENT
    PoshGram
#>
function Add-EmojiDetail {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Telegram sticker object')]
        [object]$StickerObject
    )

    try {
        $emojiData = Get-Emoji -Emoji $StickerObject.emoji
    }
    catch {
        Write-Warning -Message ('An error was encountered getting the emoji data for {0}' -f $StickerObject.emoji)
        Write-Error $_
    }

    if ($emojiData) {
        Write-Debug -Message ('Emoji data found for {0}' -f $StickerObject.emoji)
        $StickerObject | Add-Member -Type NoteProperty -Name Group -Value $emojiData.Group -Force
        $StickerObject | Add-Member -Type NoteProperty -Name SubGroup -Value $emojiData.SubGroup -Force
        $StickerObject | Add-Member -Type NoteProperty -Name Code -Value $emojiData.UnicodeStandard -Force
        $StickerObject | Add-Member -Type NoteProperty -Name pwshEscapedFormat -Value $emojiData.pwshEscapedFormat -Force
        $StickerObject | Add-Member -Type NoteProperty -Name Shortcode -Value $emojiData.ShortCode -Force
    }
    else {
        Write-Debug -Message ('No emoji data found for {0}' -f $StickerObject.emoji)
    }

    return $StickerObject
} #Add-EmojiDetail
