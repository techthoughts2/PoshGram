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
    Describe 'Send-TelegramURLPhoto' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $videoURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Intro.mp4'
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
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
                        video            = '@{duration=17; width=1920; height=1080; mime_type=video/mp4; thumb=; file_id=BAADAQADPwADiOTBRROL3QmsMu9OAg;file_size=968478}'
                        caption          = 'Video URL test'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the video extension is not supported' {
                Mock Test-URLExtension { $false }
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    VideoURL            = $videourl
                    Duration            = 16
                    Width               = 1920
                    Height              = 1080
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                    Caption             = $false
                }
                Send-TelegramURLVideo @sendTelegramURLVideoSplat | Should -Be $false
            } #it

            It 'should return false if the file is too large' {
                Mock Test-URLFileSize { $false }
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    VideoURL            = $videourl
                    Duration            = 16
                    Width               = 1920
                    Height              = 1080
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                    Caption             = $false
                }
                Send-TelegramURLVideo @sendTelegramURLVideoSplat | Should -Be $false
            } #it

            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    VideoURL            = $videourl
                    Duration            = 16
                    Width               = 1920
                    Height              = 1080
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                    Caption             = $false
                }
                Send-TelegramURLVideo @sendTelegramURLVideoSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    VideoURL            = $videourl
                    Duration            = 16
                    Width               = 1920
                    Height              = 1080
                    FileName            = 'video.mp4'
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    Caption             = $false
                }
                Send-TelegramURLVideo @sendTelegramURLVideoSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Send-TelegramURLPhoto
} #inModule
