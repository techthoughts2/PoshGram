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
            $audioURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
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
            It 'should throw if the audio extension is not supported' {
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
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLAudio @sendTelegramURLAudioSplat } | Should -Throw
            } #it

            It 'should throw if the file is too large' {
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
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLAudio @sendTelegramURLAudioSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
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
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLAudio @sendTelegramURLAudioSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
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
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLAudio @sendTelegramURLAudioSplat
                    Assert-MockCalled -CommandName Write-Warning -Times 1 -Scope It }
            } #it

            It 'should return the exception if the API returns an error' {
                Mock -CommandName Invoke-RestMethod {
                    $errorDetails = '{ "ok":false, "error_code":429, "description":"Too Many Requests: retry after 10", "parameters": { "retry_after":10 } }'
                    $statusCode = 429
                    $response = New-Object System.Net.Http.HttpResponseMessage $statusCode
                    $exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response

                    $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation

                    $errorID = 'WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand'
                    $targetObject = $null
                    $errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
                    $errorRecord.ErrorDetails = $errorDetails
                    throw $errorRecord
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
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                $eval = Send-TelegramURLAudio @sendTelegramURLAudioSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendAudio*' }
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
                    ProtectContent      = $true
                }
                Send-TelegramURLAudio @sendTelegramURLAudioSplat
                Assert-VerifiableMock
            } #it

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
                    ProtectContent      = $true
                }
                $eval = Send-TelegramURLAudio @sendTelegramURLAudioSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Functions
} #inModule
