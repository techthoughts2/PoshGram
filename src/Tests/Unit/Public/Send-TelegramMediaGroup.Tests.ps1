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
    Describe 'Send-TelegramMediaGroup' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $justRight = @(
                'photo1.jpg',
                'photo2.jpg'
            )
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            Mock Test-MediaGroupRequirements { $true }
            Mock Get-Item {
                [PSCustomObject]@{
                    Mode          = 'True'
                    LastWriteTime = '06/17/16     00:19'
                    Length        = '1902'
                    Name          = 'diagvresults.jpg'
                }
            } #endMock
            Mock Invoke-RestMethod -MockWith {
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
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the MediaGroup requirements are not met' {
                Mock Test-MediaGroupRequirements { $false }
                $sendTelegramMediaGroupSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    MediaType = 'Photo'
                    FilePaths = $justRight
                }
                Send-TelegramMediaGroup @sendTelegramMediaGroupSplat | Should -Be $false
            } #it

            It 'should return false if it cannot successfuly get the file' {
                Mock Get-Item {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramMediaGroupSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    MediaType = 'Photo'
                    FilePaths = $justRight
                }
                Send-TelegramMediaGroup @sendTelegramMediaGroupSplat | Should -Be $false
            } #it

            It 'should return false if an error is encountered sending the message' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramMediaGroupSplat = @{
                    BotToken  = $token
                    ChatID    = $chat
                    MediaType = 'Photo'
                    FilePaths = $justRight
                }
                Send-TelegramMediaGroup @sendTelegramMediaGroupSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    MediaType           = 'Photo'
                    FilePaths           = $justRight
                    DisableNotification = $true
                }
                Send-TelegramMediaGroup @sendTelegramMediaGroupSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Send-TelegramMediaGroup
} #inModule
