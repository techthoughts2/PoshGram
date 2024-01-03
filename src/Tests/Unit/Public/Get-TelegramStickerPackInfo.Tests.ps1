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
    Describe 'Get-TelegramStickerPackInfo' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Get-Emoji {
            }
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            Mock Test-PollOptions { $true }
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = [PSCustomObject]@{
                        Name           = 'STPicard'
                        title          = 'Picard'
                        is_animated    = 'False'
                        contains_masks = 'False'
                        stickers       = [PSCustomObject]@{
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
                    }
                }
            } #endMock
            Mock Get-Emoji -MockWith {
                [PSCustomObject]@{
                    Group             = 'Smileys & Emotion'
                    Subgroup          = 'face-smiling'
                    HexCodePoint      = '1F642'
                    Name              = '🙂'
                    Description       = 'slightly smiling face'
                    ShortCode         = ':slightly_smiling_face:'
                    HexCodePointArray = @('1F642')
                    UnicodeStandard   = @('U+1F642')
                    pwshEscapedFormat = '`u{1F642}'
                    Decimal           = @(128578)
                }
            }
        } #before_each

        Context 'Error' {
            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                { Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                { Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
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
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                $eval = Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error

        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*getStickerSet*' }
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                $eval = Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                $eval.width             | Should -BeExactly '512'
                $eval.height            | Should -BeExactly '512'
                $eval.emoji             | Should -BeExactly '🙂'
                $eval.set_name          | Should -BeExactly 'STPicard'
                $eval.is_animated       | Should -BeExactly 'False'
                $eval.thumb             | Should -BeExactly '@{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}'
                $eval.file_id           | Should -BeExactly 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                $eval.file_size         | Should -BeExactly '18356'
                $eval.Group             | Should -BeExactly 'Smileys & Emotion'
                $eval.Subgroup          | Should -BeExactly 'face-smiling'
                $eval.Code              | Should -Contain 'U+1F642'
                $eval.pwshEscapedFormat | Should -BeExactly '`u{1F642}'
                $eval.Shortcode         | Should -BeExactly ':slightly_smiling_face:'
            } #it
        } #context_Success
    } #describe_Get-TelegramStickerPackInfo
} #inModule
