#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------

InModuleScope PoshGram {
    Describe 'Add-EmojiDetail' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Get-Emoji {
            }
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'

            $stickerObject = [PSCustomObject]@{
                ok     = 'True'
                result = [PSCustomObject]@{
                    Name           = 'STPicard'
                    title          = 'Picard'
                    is_animated    = 'False'
                    contains_masks = 'False'
                    stickers       = [PSCustomObject]@{
                        width       = '512'
                        height      = '512'
                        emoji       = '🙂'
                        set_name    = 'STPicard'
                        is_animated = 'False'
                        thumb       = '@{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}'
                        file_id     = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                        file_size   = '18356'
                        Bytes       = '{61, 216, 66, 222}'
                        Code        = 'U+1F642'
                        Shortcode   = ':slightly_smiling_face:'
                    }
                }
            }

            Mock Get-Emoji -MockWith {
                [PSCustomObject]@{
                    Group             = 'Smileys & Emotion'
                    Subgroup          = 'face-smiling'
                    HexCodePoint      = '1F642'
                    Name              = '🙂'
                    Description       = 'slightly smiling face'
                    ShortCode         = ':slightly_smiling_face:'
                    HexCodePointArray = @('1F642')
                    UnicodeStandard   = @('U+1F642')
                    pwshEscapedFormat = '`u{1F642}'
                    Decimal           = @(128578)
                }
            } #endMock

        } #before_each

        Context 'Error' {
            It 'should not throw if an error is encountered' {
                Mock Get-Emoji -MockWith {
                    throw 'Fake Error'
                } #endMock
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                { Add-EmojiDetail -StickerObject $stickerObject.result.stickers } | Should -Not -Throw
            } #it

        } #context_Error

        Context 'Success' {

            It 'should still return the original object if no emoji data is found' {
                Mock -CommandName Get-Emoji -MockWith {
                    $null
                } #endMock

                $eval = Add-EmojiDetail -StickerObject $stickerObject.result.stickers
                $eval | Should -BeExactly $stickerObject.result.stickers
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $eval = Add-EmojiDetail -StickerObject $stickerObject.result.stickers
                $eval.width             | Should -BeExactly '512'
                $eval.height            | Should -BeExactly '512'
                $eval.emoji             | Should -BeExactly '🙂'
                $eval.set_name          | Should -BeExactly 'STPicard'
                $eval.is_animated       | Should -BeExactly 'False'
                $eval.thumb             | Should -BeExactly '@{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}'
                $eval.file_id           | Should -BeExactly 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                $eval.file_size         | Should -BeExactly '18356'
                $eval.Group             | Should -BeExactly 'Smileys & Emotion'
                $eval.Subgroup          | Should -BeExactly 'face-smiling'
                $eval.Code              | Should -Contain 'U+1F642'
                $eval.pwshEscapedFormat | Should -BeExactly '`u{1F642}'
                $eval.Shortcode         | Should -BeExactly ':slightly_smiling_face:'
            } #it
        } #context_Success

    } #describe_Add-EmojiDetail
} #inModule
