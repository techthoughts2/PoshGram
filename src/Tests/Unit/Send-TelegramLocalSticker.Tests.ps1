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
    $chat = "-#########"
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramLocalSticker' -Tag Unit {
        BeforeEach {
            mock Test-Path { $true }
            mock Test-FileExtension { $true }
            mock Test-FileSize { $true }
            mock Get-Item {
                [PSCustomObject]@{
                    Mode          = "True"
                    LastWriteTime = "06/17/16     00:19"
                    Length        = "1902"
                    Name          = "sticker.webp"
                }
            }#endMock
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id = '1633'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571380664'
                        sticker    = '@{width=512; height=512; is_animated=False; thumb=; file_id=CAADAQADXwADosBJRZFkfz2a9xe2FgQ; file_size=18356}'
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the sticker can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" | Should -Be $false
            }#it
            It 'should return false if the sticker extension is not supported' {
                mock Test-FileExtension { $false }
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" | Should -Be $false
            }#it
            It 'should return false if the sticker is too large' {
                mock Test-FileSize { $false }
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerPath "c:\bs\sticker.webp" `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Success
    }#describe_Send-TelegramLocalSticker
}#inModule