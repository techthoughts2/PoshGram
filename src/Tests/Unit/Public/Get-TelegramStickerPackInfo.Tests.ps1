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
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    $token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    function Write-Error {
    }
    #-------------------------------------------------------------------------
    Describe 'Get-TelegramStickerPackInfo' -Tag Unit {
        BeforeEach {
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
            }#endMock
            Mock Get-Content -MockWith {
                '[
                    {
                        "KDDI": "🙂",
                        "Softbank": "slightly smiling face",
                        "Google": ":slightly_smiling_face:",
                        "Sheet": "U+1F642",
                        "FIELD11": "-",
                        "FIELD12": "-",
                        "FIELD13": "-",
                        "FIELD14": "-",
                        "FIELD15": "1f642.png",
                        "FIELD16": "32,3"
                    }
                ]'
            }
        }#before_each
        Context 'Error' {
            It 'should return false if an error is encountered getting sticker pack information' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return $false if the sticker pack is not found' {
                Mock Invoke-RestMethod -MockWith {
                    [System.Exception]$exception = "The remote server returned an error: (400) Bad Request."
                    [System.String]$errorId = 'BadRequest'
                    [Management.Automation.ErrorCategory]$errorCategory = [Management.Automation.ErrorCategory]::InvalidOperation
                    [System.Object]$target = 'Whatevs'
                    $errorRecord = New-Object Management.Automation.ErrorRecord ($exception, $errorID, $errorCategory, $target)
                    [System.Management.Automation.ErrorDetails]$errorDetails = '{"ok":false,"error_code":400,"description":"Bad Request: STICKERSET_INVALID"}'
                    $errorRecord.ErrorDetails = $errorDetails
                    throw $errorRecord
                }
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'Nope'
                }
                Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                $getTelegramStickerPackInfoSplat = @{
                    BotToken       = $token
                    StickerSetName = 'STPicard'
                }
                $eval = Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                $eval.width       | Should -BeExactly '512'
                $eval.height      | Should -BeExactly '512'
                $eval.emoji       | Should -BeExactly '🙂'
                $eval.set_name    | Should -BeExactly 'STPicard'
                $eval.is_animated | Should -BeExactly 'False'
                $eval.thumb       | Should -BeExactly '@{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}'
                $eval.file_id     | Should -BeExactly 'CAADAgADDAAD3XATF5dBRoC9vn3aFgQ'
                $eval.file_size   | Should -BeExactly '18356'
                $eval.Code        | Should -BeExactly 'U+1F642'
                $eval.Shortcode   | Should -BeExactly ':slightly_smiling_face:'
            }#it
        }#context_Success
    }#describe_Get-TelegramStickerPackInfo
}#inModule
