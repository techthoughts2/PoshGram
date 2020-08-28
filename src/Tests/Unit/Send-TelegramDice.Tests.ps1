#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
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
    $chat = "-nnnnnnnnn"
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramDice' -Tag Unit {
        Context 'Error' {
            It 'should throw if an invalid Emoji option is provided' {
                {
                    $sendTelegramDiceSplat = @{
                        BotToken            = $token
                        ChatID              = $chat
                        Emoji               = 'soccer'
                        DisableNotification = $true
                        ErrorAction         = 'SilentlyContinue'
                    }
                    Send-TelegramDice @sendTelegramDiceSplat
                } | Should throw
            }#it
            It 'should return false if an error is encountered sending the dice' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'basketball'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramDice @sendTelegramDiceSplat | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id = 2222
                            from       = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat       = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date       = "1530157540"
                            dice       = @{
                                emoji = '🎲'
                                value = 2
                            }
                        }
                    }
                }#endMock
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'dice'
                    DisableNotification = $true
                }
                Send-TelegramDice @sendTelegramDiceSplat | Should -BeOfType System.Management.Automation.PSCustomObject
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Emoji               = 'dart'
                    DisableNotification = $true
                }
                $eval = Send-TelegramDice @sendTelegramDiceSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_success
    }#describe_Send-TelegramDice
}#inModule