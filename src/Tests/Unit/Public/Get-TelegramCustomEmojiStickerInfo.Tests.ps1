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

    Describe 'Get-TelegramCustomEmojiStickerInfo' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Get-Emoji {
            }
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $tooManyIdentifiers = New-Object System.Collections.Generic.List[string]
            $identifer = '5404870433939922908'
            for ($i = 0; $i -lt 201; $i++) {
                $tooManyIdentifiers.Add((Get-Random))
            }
            Mock Invoke-RestMethod -MockWith {
                @(
                    [PSCustomObject]@{
                        ok     = $true
                        result = [PSCustomObject]@{
                            width           = '512'
                            height          = '512'
                            emoji           = '🌈'
                            set_name        = 'MemeEmoji'
                            is_animated     = 'True'
                            is_video        = 'False'
                            type            = 'custom_emoji'
                            custom_emoji_id = '5404870433939922908'
                            thumbnail       = '@{file_id=AAMCAgADFQABZZriegQ9yZ3Rt9ZDge7TW1jIkH0AAtwfAAIG9QFLbIY6gKwVti8BAAdtAAM0BA; file_unique_id=AQAD3B8AAgb1AUty; file_size=5032; width=128; height=128}'
                            thumb           = '@{file_id=AAMCAgADFQABZZriegQ9yZ3Rt9ZDge7TW1jIkH0AAtwfAAIG9QFLbIY6gKwVti8BAAdtAAM0BA; file_unique_id=AQAD3B8AAgb1AUty; file_size=5032; width=128; height=128}'
                            file_id         = 'CAACAgIAAxUAAWWa4noEPcmd0bfWQ4Hu01tYyJB9AALcHwACBvUBS2yGOoCsFbYvNAQ'
                            file_unique_id  = 'AgAD3B8AAgb1AUs'
                            file_size       = '24506'
                        }
                    }

                    [PSCustomObject]@{
                        ok     = $true
                        result = [PSCustomObject]@{
                            width           = '512'
                            height          = '512'
                            emoji           = '👍'
                            set_name        = 'HandEmoji'
                            is_animated     = 'True'
                            is_video        = 'False'
                            type            = 'custom_emoji'
                            custom_emoji_id = '5368324170671202286'
                            thumbnail       = '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                            thumb           = '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                            file_id         = 'CAACAgIAAxUAAWWa51_M_xijPg1eu-MGF23klcuQAALuHwACZB6AShr4a8S683-cNAQ'
                            file_unique_id  = 'AgAD7h8AAmQegEo'
                            file_size       = '13783'
                        }
                    }
                )
            } #endMock
            Mock Add-EmojiDetail -MockWith {
                [PSCustomObject]@{
                    width             = '512'
                    height            = '512'
                    emoji             = '👍'
                    set_name          = 'HandEmoji'
                    is_animated       = 'True'
                    is_video          = 'False'
                    type              = 'custom_emoji'
                    custom_emoji_id   = '5368324170671202286'
                    thumbnail         = '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                    thumb             = '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                    file_id           = 'CAACAgIAAxUAAWWa51_M_xijPg1eu-MGF23klcuQAALuHwACZB6AShr4a8S683-cNAQ'
                    file_unique_id    = 'AgAD7h8AAmQegEo'
                    file_size         = '13783'
                    Group             = 'People & Body'
                    Subgroup          = 'hand-fingers-closed'
                    Code              = @('U+1F44D')
                    pwshEscapedFormat = '`u{1F44D}'
                    Shortcode         = ':thumbs_up:'
                }
            } #endMock

        } #before_each

        Context 'Error' {

            It 'should throw if too many identifiers are passed' {
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $tooManyIdentifiers
                }
                { Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer
                }
                { Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer
                }
                { Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat
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
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer
                }
                $eval = Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error

        Context 'Success' {

            It 'should not throw if a supported number of identifiers are passed' {
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer
                }
                { Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat } | Should -Not -Throw
            } #it

            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*getCustomEmojiStickers*' }
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer
                }
                Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat
                Assert-VerifiableMock
            } #it

            It 'should return a custom PSCustomObject if successful' {
                $getTelegramCustomEmojiStickerInfoSplat = @{
                    BotToken              = $token
                    CustomEmojiIdentifier = $identifer, '5368324170671202286'
                }
                $eval = Get-TelegramCustomEmojiStickerInfo @getTelegramCustomEmojiStickerInfoSplat
                $eval[1].width             | Should -BeExactly '512'
                $eval[1].height            | Should -BeExactly '512'
                $eval[1].emoji             | Should -BeExactly '👍'
                $eval[1].set_name          | Should -BeExactly 'HandEmoji'
                $eval[1].is_animated       | Should -BeExactly 'True'
                $eval[1].is_video          | Should -BeExactly 'False'
                $eval[1].type              | Should -BeExactly 'custom_emoji'
                $eval[1].custom_emoji_id   | Should -BeExactly '5368324170671202286'
                $eval[1].thumbnail         | Should -BeExactly '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                $eval[1].thumb             | Should -BeExactly '@{file_id=AAMCAgADFQABZZrnX8z_GKM-DV674wYXbeSVy5AAAu4fAAJkHoBKGvhrxLrzf5wBAAdtAAM0BA; file_unique_id=AQAD7h8AAmQegEpy; file_size=4048; width=128; height=128}'
                $eval[1].file_id           | Should -BeExactly 'CAACAgIAAxUAAWWa51_M_xijPg1eu-MGF23klcuQAALuHwACZB6AShr4a8S683-cNAQ'
                $eval[1].file_unique_id    | Should -BeExactly 'AgAD7h8AAmQegEo'
                $eval[1].file_size         | Should -BeExactly '13783'
                $eval[1].Group             | Should -BeExactly 'People & Body'
                $eval[1].Subgroup          | Should -BeExactly 'hand-fingers-closed'
                $eval[1].Code              | Should -BeExactly @('U+1F44D')
                $eval[1].pwshEscapedFormat | Should -BeExactly '`u{1F44D}'
                $eval[1].Shortcode         | Should -BeExactly ':thumbs_up:'
            } #it

        } #context_Success
    } #describe_Get-TelegramCustomEmojiStickerInfo

} #inModule
