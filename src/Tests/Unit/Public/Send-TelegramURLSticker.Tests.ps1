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
    Describe 'Send-TelegramURLSticker' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            $stickerURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.webp'
            Mock Test-URLExtension { $true }
            Mock Test-URLFileSize { $true }
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = '1635'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571382575'
                        sticker    = '@{width=512; height=512; is_animated=False; thumb=; file_id=CAADBAADkAEAAvRXTVFFkzUj6CRvGRYE; file_size=18356}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the sticker extension is not supported' {
                Mock Test-URLExtension { $false }
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLSticker @sendTelegramURLStickerSplat } | Should -Throw
            } #it

            It 'should return false if the file is too large' {
                Mock Test-URLFileSize { $false }
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLSticker @sendTelegramURLStickerSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLSticker @sendTelegramURLStickerSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                { Send-TelegramURLSticker @sendTelegramURLStickerSplat
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
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                $eval = Send-TelegramURLSticker @sendTelegramURLStickerSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendSticker*' }
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramURLSticker @sendTelegramURLStickerSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerURL          = $stickerURL
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramURLSticker @sendTelegramURLStickerSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_success
    } #describe_Send-TelegramURLSticker
} #inModule
