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
    Describe 'Send-TelegramLocalAudio' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            Mock Test-Path { $true }
            Mock Test-FileExtension { $true }
            Mock Test-FileSize { $true }
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
                        audio            = '@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}'
                        caption          = 'Local Video Test'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the audio can not be found' {
                Mock Test-Path { $false }
                $sendTelegramLocalAudioSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Audio    = 'C:\bs\audio.mp3'
                }
                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -Be $false
            } #it

            It 'should return false if the audio extension is not supported' {
                Mock Test-FileExtension { $false }
                $sendTelegramLocalAudioSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Audio    = 'C:\bs\audio.mp3'
                }
                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -Be $false
            } #it

            It 'should return false if the audio is too large' {
                Mock Test-FileSize { $false }
                $sendTelegramLocalAudioSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Audio    = 'C:\bs\audio.mp3'
                }

                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -Be $false
            } #it

            It 'should return false if it cannot successfuly get the file' {
                Mock Get-Item {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramLocalAudioSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Audio    = 'C:\bs\audio.mp3'
                }
                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -Be $false
            } #it

            It 'should return false if an error is encountered sending the message' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramLocalAudioSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    Audio       = 'C:\bs\audio.mp3'
                    ErrorAction = 'SilentlyContinue'
                }

                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -Be $false
            } #it

        } #context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramLocalAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Audio               = 'C:\bs\audio.mp3'
                    Caption             = 'Check out this audio track'
                    ParseMode           = 'MarkdownV2'
                    Duration            = 495
                    Performer           = 'Metallica'
                    Title               = 'Halo On Fire'
                    FileName            = 'audio.mp3'
                    DisableNotification = $true
                }
                Send-TelegramLocalAudio @sendTelegramLocalAudioSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_Success
    } #describe_Send-TelegramLocalAudio
} #inModule
