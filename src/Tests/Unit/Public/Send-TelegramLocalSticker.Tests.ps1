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
    Describe 'Send-TelegramLocalSticker' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            Mock Test-Path { $true }
            Mock Test-FileExtension { $true }
            Mock Test-FileSize { $true }
            Mock Get-Item {
                [PSCustomObject]@{
                    Mode          = 'True'
                    LastWriteTime = '06/17/16     00:19'
                    Length        = '1902'
                    Name          = 'sticker.webp'
                }
            } #endMock
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = '1633'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571380664'
                        sticker    = '@{width=512; height=512; is_animated=False; thumb=; file_id=CAADAQADXwADosBJRZFkfz2a9xe2FgQ; file_size=18356}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the sticker can not be found' {
                Mock Test-Path { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -Be $false
            } #it

            It 'should return false if the sticker extension is not supported' {
                Mock Test-FileExtension { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -Be $false
            } #it

            It 'should return false if the sticker is too large' {
                Mock Test-FileSize { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -Be $false
            } #it

            It 'should return false if it cannot successfuly get the file' {
                Mock Get-Item {
                    Throw 'Bullshit Error'
                } #endMock
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -Be $false
            } #it

            It 'should return false if an error is encountered sending the message' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                } #endMock
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                    ErrorAction = 'SilentlyContinue'
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -Be $false
            } #it
        } #context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramLocalStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerPath         = 'c:\bs\sticker.webp'
                    DisableNotification = $true
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_Success
    } #describe_Send-TelegramLocalSticker
} #inModule
