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
    Describe 'Send-TelegramURLSticker' -Tag Unit {
        $StickerURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.webp"
        BeforeEach {
            mock Test-URLExtension { $true }
            mock Test-URLFileSize { $true }
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id = '1635'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571382575'
                        sticker    = '@{width=512; height=512; is_animated=False; thumb=; file_id=CAADBAADkAEAAvRXTVFFkzUj6CRvGRYE; file_size=18356}'
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the sticker extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerURL $StickerURL `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLFileSize { $false }
                Send-TelegramURLSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerURL $StickerURL `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerURL $StickerURL `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramURLSticker `
                    -BotToken $token `
                    -ChatID $chat `
                    -StickerURL $StickerURL `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramURLSticker
}#inModule