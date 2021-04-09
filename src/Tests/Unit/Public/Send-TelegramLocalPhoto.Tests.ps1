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
$WarningPreference = 'SilentlyContinue'
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = 'SilentlyContinue'
    $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramLocalPhoto' -Tag Unit {
        BeforeEach {
            mock Test-Path { $true }
            mock Test-FileExtension { $true }
            mock Test-FileSize { $true }
            mock Get-Item {
                [PSCustomObject]@{
                    Mode          = 'True'
                    LastWriteTime = '06/17/16     00:19'
                    Length        = '1902'
                    Name          = 'diagvresults.jpg'
                }
            }#endMock
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id       = 2222
                        from             = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                        chat             = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                        date             = '1530157540'
                        photo            = '{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}'
                        caption          = 'Please work, please'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the photo can not be found' {
                mock Test-Path { $false }
                $sendTelegramLocalPhotoSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    PhotoPath = 'c:\bs\diagvresults.jpg'
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -Be $false
            }#it
            It 'should return false if the photo extension is not supported' {
                mock Test-FileExtension { $false }
                $sendTelegramLocalPhotoSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    PhotoPath = 'c:\bs\diagvresults.jpg'
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -Be $false
            }#it
            It 'should return false if the photo is too large' {
                mock Test-FileSize { $false }
                $sendTelegramLocalPhotoSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    PhotoPath = 'c:\bs\diagvresults.jpg'
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramLocalPhotoSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    PhotoPath = 'c:\bs\diagvresults.jpg'
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramLocalPhotoSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    PhotoPath   = 'c:\bs\diagvresults.jpg'
                    ErrorAction = 'SilentlyContinue'
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramLocalPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoPath           = 'c:\bs\diagvresults.jpg'
                    Caption             = 'Check out this photo'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                }
                Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Success
    }#describe_Send-TelegramLocalPhoto
}#inModule