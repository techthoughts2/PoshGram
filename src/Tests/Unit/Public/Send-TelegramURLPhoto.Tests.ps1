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
            $photoURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'
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
                        photo            = '{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}'
                        caption          = 'Please work, please'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if the photo extension is not supported' {
                Mock Test-URLExtension { $false }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLPhoto @sendTelegramURLPhotoSplat } | Should -Throw
            } #it

            It 'should throw if the file is too large' {
                Mock Test-URLFileSize { $false }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLPhoto @sendTelegramURLPhotoSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLPhoto @sendTelegramURLPhotoSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
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
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                $eval = Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendphoto*' }
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    PhotoURL            = $photoURL
                    Caption             = 'DSC is a great technology'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramURLPhoto
} #inModule
