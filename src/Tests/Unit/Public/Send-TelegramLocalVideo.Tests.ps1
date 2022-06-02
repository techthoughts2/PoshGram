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
    Describe 'Send-TelegramLocalVideo' -Tag Unit {
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
                        video            = '@{duration=17; width=1920; height=1080; mime_type=video/mp4; thumb=; file_id=BAADAQADPwADiOTBRROL3QmsMu9OAg;file_size=968478}'
                        caption          = 'Local Video Test'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if the video can not be found' {
                Mock Test-Path { $false }
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat } | Should -Throw
            } #it

            It 'should throw if the video extension is not supported' {
                Mock Test-FileExtension { $false }
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat } | Should -Throw
            } #it

            It 'should throw if the video is too large' {
                Mock Test-FileSize { $false }
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat } | Should -Throw
            } #it

            It 'should throw if it cannot successfully get the file' {
                Mock Get-Item {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                { Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
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
                $sendTelegramLocalVideoSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Video    = 'C:\bs\video.mp4'
                }
                $eval = Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendVideo*' }
                $sendTelegramLocalVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Video               = 'C:\bs\video.mp4'
                    Duration            = 10
                    Width               = 250
                    Height              = 250
                    FileName            = 'video.mp4'
                    Caption             = 'Check out this video'
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramLocalVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Video               = 'C:\bs\video.mp4'
                    Duration            = 10
                    Width               = 250
                    Height              = 250
                    FileName            = 'video.mp4'
                    Caption             = 'Check out this video'
                    ParseMode           = 'MarkdownV2'
                    Streaming           = $true
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramLocalVideo
} #inModule
