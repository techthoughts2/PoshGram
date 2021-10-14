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
    Describe 'Send-TelegramLocation' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
        } #before_each
        Context 'Error' {
            It 'should return false if an error is encountered sending the location' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramLocationSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Latitude            = 37.621313
                    Longitude           = '-122.378955'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramLocation @sendTelegramLocationSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = 'True'
                        result = @{
                            message_id       = 2222
                            from             = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                            chat             = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                            date             = '1530157540'
                            audio            = '@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}'
                            caption          = 'Video URL test'
                            caption_entities = '{@{offset=13; length=6; type=bold}}'
                        }
                    }
                } #endMock
                $sendTelegramLocationSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Latitude            = 37.621313
                    Longitude           = '-122.378955'
                    DisableNotification = $true
                }
                Send-TelegramLocation @sendTelegramLocationSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Send-TelegramLocation
} #inModule
