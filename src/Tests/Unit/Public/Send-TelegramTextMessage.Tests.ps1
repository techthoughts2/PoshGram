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
    Describe 'Send-TelegramTextMessage' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $inlineRow1 = @(
                @{
                    text = "`u{1F517} Visit"
                    url  = 'https://www.techthoughts.info'
                }
            )
            $inlineRow2 = @(
                @{
                    text = "`u{1F4CC} Pin"
                    url  = 'https://www.techthoughts.info/learn-powershell-series/'
                }
            )
            $inlineKeyboard = @{
                inline_keyboard = @(
                    $inlineRow1,
                    $inlineRow2
                )
            }
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = 2222
                        from       = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                        chat       = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                        date       = '1530157540'
                        text       = 'Catesta is cool.'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramTextMessageSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    Message     = 'Hi there Pester'
                    ErrorAction = 'SilentlyContinue'
                }
                { Send-TelegramTextMessage @sendTelegramTextMessageSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramTextMessageSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    Message     = 'Hi there Pester'
                    ErrorAction = 'SilentlyContinue'
                }
                { Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    Should -Invoke -CommandName Write-Warning -Times 1 -Scope It }
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
                $sendTelegramTextMessageSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    Message     = 'Hi there Pester'
                    ErrorAction = 'SilentlyContinue'
                }
                $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendMessage*' }
                $sendTelegramTextMessageSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Message  = 'Hi there Pester'
                }
                Send-TelegramTextMessage @sendTelegramTextMessageSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramTextMessageSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Message  = 'Hi there Pester'
                }
                $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it

            It 'should return a custom PSCustomObject if successful when sending a keyboard' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Message             = 'Hi there Pester'
                    ParseMode           = 'MarkdownV2'
                    DisablePreview      = $true
                    DisableNotification = $true
                    ProtectContent      = $true
                    Keyboard            = $inlineKeyboard
                }
                $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramTextMessage
} #inModule
