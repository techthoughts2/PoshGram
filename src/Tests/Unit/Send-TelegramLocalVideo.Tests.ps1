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
    Describe 'Send-TelegramLocalVideo' -Tag Unit {
        BeforeEach {
            mock Test-Path { $true }
            mock Test-FileExtension { $true }
            mock Test-FileSize { $true }
            mock Get-Item {
                [PSCustomObject]@{
                    Mode          = "True"
                    LastWriteTime = "06/17/16     00:19"
                    Length        = "1902"
                    Name          = "diagvresults.jpg"
                }
            }#endMock
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id       = 2222
                        from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                        chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                        date             = "1530157540"
                        video            = "@{duration=17; width=1920; height=1080; mime_type=video/mp4; thumb=; file_id=BAADAQADPwADiOTBRROL3QmsMu9OAg;file_size=968478}"
                        caption          = "Local Video Test"
                        caption_entities = "{@{offset=13; length=6; type=bold}}"
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the video can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if the video extension is not supported' {
                mock Test-FileExtension { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if the video is too large' {
                mock Test-FileSize { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" `
                    -Duration 10 `
                    -Width 250 `
                    -Height 250 `
                    -Caption "Check out this video" `
                    -ParseMode Markdown `
                    -Streaming `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramLocalVideo
}#inModule