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
$WarningPreference = 'SilentlyContinue'
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = 'SilentlyContinue'
    $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    #-------------------------------------------------------------------------
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
    Describe 'Send-TelegramTextMessage' -Tag Unit {
        BeforeEach {
            mock Invoke-RestMethod -MockWith {
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
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramTextMessageSplat = @{
                    BotToken    = $token
                    ChatID      = $chat
                    Message     = 'Hi there Pester'
                    ErrorAction = 'SilentlyContinue'
                }
                Send-TelegramTextMessage @sendTelegramTextMessageSplat | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramTextMessageSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    Message  = 'Hi there Pester'
                }
                Send-TelegramTextMessage @sendTelegramTextMessageSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
            It 'should return a custom PSCustomObject if successful when sending a keyboard' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Message             = 'Hi there Pester'
                    ParseMode           = 'MarkdownV2'
                    DisablePreview      = $true
                    DisableNotification = $true
                    Keyboard            = $inlineKeyboard
                }
                Send-TelegramTextMessage @sendTelegramTextMessageSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramTextMessage
}#inModule