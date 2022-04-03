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
    Describe 'Send-TelegramSticker' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = '1628'
                        from       = '@{id=515383114; is_bot=True; first_name=poshgram; username=poshgram_bot}'
                        chat       = '@{id=-192990862; title=PoshGram Testing; type=group; all_members_are_administrators=True}'
                        date       = '1571374330'
                        sticker    = '@{width=512; height=512; emoji=🙂; set_name=STPicard; is_animated=False; thumb=; file_id=CAADAgADCwAD3XATF_qdh42c06D5FgQ; file_size=1698'
                    }
                }
            } #endMock
            Mock Get-TelegramStickerPackInfo -MockWith {
                [PSCustomObject]@{
                    width       = '512'
                    height      = '512'
                    emoji       = '🙂'
                    set_name    = 'STPicard'
                    is_animated = 'False'
                    thumb       = '@{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}'
                    file_id     = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    file_size   = '18356'
                    Bytes       = '{61, 216, 66, 222}'
                    Code        = 'U+1F642'
                    Shortcode   = ':slightly_smiling_face:'
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if shortcode is specified but the sticker pack can not be found' {
                Mock Get-TelegramStickerPackInfo -MockWith { $false }
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ":grinning:"
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramSticker @sendTelegramStickerSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramSticker @sendTelegramStickerSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramSticker @sendTelegramStickerSplat
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
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramSticker @sendTelegramStickerSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendSticker*' }
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ':slightly_smiling_face:'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramSticker @sendTelegramStickerSplat
                Assert-VerifiableMock
            } #it

            It 'should throw if the shortcode provided is not found in the sticker pack' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ':grinning:'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramSticker @sendTelegramStickerSplat } | Should -Throw
            } #it

            It 'should return a PSCustomObject if no errors are encountered and FileID is specified' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileID              = 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramSticker @sendTelegramStickerSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it

            It 'should return a PSCustomObject if no errors are encountered and shortcode is specified' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    StickerSetName      = 'STPicard'
                    Shortcode           = ':slightly_smiling_face:'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramSticker @sendTelegramStickerSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -BeExactly 'True'
            } #it
        } #context_Success
    } #describe_Send-TelegramSticker
} #inModule
