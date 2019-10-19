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
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramLocation' -Tag Unit {
        Context 'Error' {
            It 'should return false if an error is encountered sending the location' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Latitude 37.621313 `
                    -Longitude -122.378955 `
                    -DisableNotification `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
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
                Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Latitude 37.621313 `
                    -Longitude -122.378955 `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramLocation
}#inModule