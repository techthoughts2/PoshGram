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
    Describe 'Send-TelegramDice' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
        } #before_each
        Context 'Error' {
            It 'should throw if an invalid Emoji option is provided' {
                {
                    $sendTelegramDiceSplat = @{
                        BotToken            = $token
                        ChatID              = $chat
                        Emoji               = 'soccer'
                        DisableNotification = $true
                        ProtectContent      = $true
                        ErrorAction         = 'SilentlyContinue'
                    }
                    Send-TelegramDice @sendTelegramDiceSplat
                } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'basketball'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramDice @sendTelegramDiceSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'basketball'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramDice @sendTelegramDiceSplat
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
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'basketball'
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                $eval = Send-TelegramDice @sendTelegramDiceSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendDice*' }
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'bowling'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramDice @sendTelegramDiceSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                Mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = 'True'
                        result = @{
                            message_id = 2222
                            from       = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                            chat       = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                            date       = '1530157540'
                            dice       = @{
                                emoji = '🎲'
                                value = 2
                            }
                        }
                    }
                } #endMock
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'dice'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramDice @sendTelegramDiceSplat | Should -BeOfType System.Management.Automation.PSCustomObject
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'football'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramDice @sendTelegramDiceSplat | Should -BeOfType System.Management.Automation.PSCustomObject
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'slotmachine'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramDice @sendTelegramDiceSplat | Should -BeOfType System.Management.Automation.PSCustomObject
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'dart'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramDice @sendTelegramDiceSplat
                $eval.ok | Should -Be 'True'
                Send-TelegramDice @sendTelegramDiceSplat | Should -BeOfType System.Management.Automation.PSCustomObject
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'bowling'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramDice @sendTelegramDiceSplat
                $eval.ok | Should -Be 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramDice
} #inModule
