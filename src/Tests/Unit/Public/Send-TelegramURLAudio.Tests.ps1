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
    Describe 'Send-TelegramURLAudio' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            $audioURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
            Mock Test-URLExtension { $true }
            Mock Test-URLFileSize { $true }
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
        } #before_each
        Context 'Error' {
            It 'should return false if the audio extension is not supported' {
                Mock Test-URLExtension { $false }
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    AudioURL            = $audioURL
                    Caption             = 'Check out this audio track'
                    ParseMode           = 'MarkdownV2'
                    Duration            = 495
                    Performer           = 'Metallica'
                    Title               = 'Halo On Fire'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLAudio @sendTelegramURLAudioSplat | Should -Be $false
            } #it
            It 'should return false if the file is too large' {
                Mock Test-URLFileSize { $false }
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    AudioURL            = $audioURL
                    Caption             = 'Check out this audio track'
                    ParseMode           = 'MarkdownV2'
                    Duration            = 495
                    Performer           = 'Metallica'
                    Title               = 'Halo On Fire'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLAudio @sendTelegramURLAudioSplat | Should -Be $false
            } #it
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    AudioURL            = $audioURL
                    Caption             = 'Check out this audio track'
                    ParseMode           = 'MarkdownV2'
                    Duration            = 495
                    Performer           = 'Metallica'
                    Title               = 'Halo On Fire'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLAudio @sendTelegramURLAudioSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    AudioURL            = $audioURL
                    Caption             = 'Check out this audio track'
                    ParseMode           = 'MarkdownV2'
                    Duration            = 495
                    Performer           = 'Metallica'
                    Title               = 'Halo On Fire'
                    FileName            = 'audio.mp3'
                    DisableNotification = $true
                }
                Send-TelegramURLAudio @sendTelegramURLAudioSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Functions
} #inModule
