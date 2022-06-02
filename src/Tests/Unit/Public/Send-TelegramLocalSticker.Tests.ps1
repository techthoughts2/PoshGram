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
    Describe 'Send-TelegramLocalSticker' -Tag Unit {
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
                    Name          = 'sticker.webp'
                }
            } #endMock
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = '1633'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571380664'
                        sticker    = '@{width=512; height=512; is_animated=False; thumb=; file_id=CAADAQADXwADosBJRZFkfz2a9xe2FgQ; file_size=18356}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if the sticker can not be found' {
                Mock Test-Path { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat } | Should -Throw
            } #it

            It 'should throw if the sticker extension is not supported' {
                Mock Test-FileExtension { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat } | Should -Throw
            } #it

            It 'should throw if the sticker is too large' {
                Mock Test-FileSize { $false }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat } | Should -Throw
            } #it

            It 'should throw if it cannot successfully get the file' {
                Mock Get-Item {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                    ErrorAction = 'SilentlyContinue'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                    ErrorAction = 'SilentlyContinue'
                }
                { Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
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
                $sendTelegramLocalStickerSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    StickerPath = 'c:\bs\sticker.webp'
                    ErrorAction = 'SilentlyContinue'
                }
                $eval = Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendSticker*' }
                $sendTelegramLocalStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerPath         = 'c:\bs\sticker.webp'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramLocalStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerPath         = 'c:\bs\sticker.webp'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_Success
    } #describe_Send-TelegramLocalSticker
} #inModule
