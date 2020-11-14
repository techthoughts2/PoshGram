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
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    $token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-nnnnnnnnn"
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramURLPhoto' -Tag Unit {
        $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
        BeforeEach {
            mock Test-URLExtension { $true }
            mock Test-URLFileSize { $true }
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id       = 2222
                        from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                        chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                        date             = "1530157540"
                        photo            = "{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}"
                        caption          = "Please work, please"
                        caption_entities = "{@{offset=13; length=6; type=bold}}"
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the photo extension is not supported' {
                mock Test-URLExtension { $false }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = "DSC is a great technology"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLPhoto @sendTelegramURLPhotoSplat | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLFileSize { $false }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = "DSC is a great technology"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLPhoto @sendTelegramURLPhotoSplat | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = "DSC is a great technology"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLPhoto @sendTelegramURLPhotoSplat | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = "DSC is a great technology"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                }
                Send-TelegramURLPhoto @sendTelegramURLPhotoSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramURLPhoto
}#inModule