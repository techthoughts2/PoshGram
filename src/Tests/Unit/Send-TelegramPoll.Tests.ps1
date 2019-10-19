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
    function Write-Error {}
    #-------------------------------------------------------------------------
    Describe 'Send-TelegramPoll' -Tag Unit {
        $question = 'What is your favorite Star Trek series?'
        $opt = @(
            'Star Trek: The Original Series',
            'Star Trek: The Animated Series',
            'Star Trek: The Next Generation',
            'Star Trek: Deep Space Nine',
            'Star Trek: Voyager',
            'Star Trek: Enterprise',
            'Star Trek: Discovery',
            'Star Trek: Picard'
        )
        BeforeEach {
            mock Test-PollOptions { $true }
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id       = 2222
                        from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                        chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                        date             = "1530157540"
                        poll             = "@{id=4987907110399377412; question=What is your favorite Star Trek series?; options=System.Object[]; is_closed=False}"
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if poll options do not meet Telegram requirements' {
                mock Test-PollOptions { $false }
                Send-TelegramPoll `
                    -BotToken $token `
                    -ChatID $chat `
                    -Question $question `
                    -Options $opt `
                    -DisableNotification `
                    | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the poll' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramPoll `
                    -BotToken $token `
                    -ChatID $chat `
                    -Question $question `
                    -Options $opt `
                    -DisableNotification `
                    | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Send-TelegramPoll `
                    -BotToken $token `
                    -ChatID $chat `
                    -Question $question `
                    -Options $opt `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Success
    }#describe_Send-TelegramPoll
}#inModule