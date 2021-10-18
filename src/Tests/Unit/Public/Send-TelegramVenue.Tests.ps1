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
    Describe 'Send-TelegramVenue' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
        } #before_each
        Context 'Error' {
            It 'should throw if an error is encountered sending the location' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramVenueSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Latitude            = 37.621313
                    Longitude           = '-122.378955'
                    Title               = 'Star Fleet Headquarters'
                    Address             = 'San Francisco, CA 94128'
                    DisableNotification = $true
                }
                { Send-TelegramVenue @sendTelegramVenueSplat } | Should -Throw
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendVenue*' }
                $sendTelegramVenueSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Latitude            = 37.621313
                    Longitude           = '-122.378955'
                    Title               = 'Star Fleet Headquarters'
                    Address             = 'San Francisco, CA 94128'
                    DisableNotification = $true
                }
                Send-TelegramVenue @sendTelegramVenueSplat
                Assert-VerifiableMock
            } #it

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
                $sendTelegramVenueSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Latitude            = 37.621313
                    Longitude           = '-122.378955'
                    Title               = 'Star Fleet Headquarters'
                    Address             = 'San Francisco, CA 94128'
                    DisableNotification = $true
                }
                $eval = Send-TelegramVenue @sendTelegramVenueSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramVenue
} #inModule
