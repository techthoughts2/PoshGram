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
    Describe 'Send-TelegramTextMessage' -Tag Unit {
        BeforeEach {
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id = 2222
                        from       = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                        chat       = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                        date       = "1530157540"
                        text       = "Diag-V is cool."
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramTextMessage `
                    -BotToken $token `
                    -ChatID $chat `
                    -Message "Hi there Pester" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramTextMessage `
                    -BotToken $token `
                    -ChatID $chat `
                    -Message "Hi There Pester" `
                | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramTextMessage
}#inModule