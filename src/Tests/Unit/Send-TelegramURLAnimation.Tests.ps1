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
    Describe 'Send-TelegramURLAnimation' -Tag Unit {
        $animationURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/jean.gif"
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
                        audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                        caption          = "Video URL test"
                        caption_entities = "{@{offset=13; length=6; type=bold}}"
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if the animation extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLFileSize { $false }
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramURLAnimation
}#inModule