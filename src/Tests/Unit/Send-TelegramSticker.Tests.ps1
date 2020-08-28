#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    $token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    function Write-Error {
    }
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramSticker' -Tag Unit {
        BeforeEach {
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id = '1628'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571374330'
                        sticker    = '@{width=512; height=512; emoji=🙂; set_name=STPicard; is_animated=False; thumb=; file_id=CAADAgADCwAD3XATF_qdh42c06D5FgQ; file_size=1698'
                    }
                }
            }#endMock
            Mock Get-TelegramStickerPackInfo -MockWith {
                [PSCustomObject]@{
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
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if an error is encountered sending the sticker' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat | Should -Be $false
            }#it
            It 'should return false if shortcode is specified but the sticker pack can not be found' {
                Mock Get-TelegramStickerPackInfo -MockWith { $false }
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ":grinning:"
                    DisableNotification = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return false if the shortcode provided is not found in the sticker pack' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ":grinning:"
                    DisableNotification = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat | Should -Be $false
            }#it
            It 'should return a PSCustomObject if no errors are encountered and FileID is specified' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
            It 'should return a PSCustomObject if no errors are encountered and shortcode is specified' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ":slightly_smiling_face:"
                    DisableNotification = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Success
    }#describe_Send-TelegramSticker
}#inModule
