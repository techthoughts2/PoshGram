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
    function Write-Error {
    }
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
        $question2 = 'Who was the best Starfleet captain?'
        $opt2 = @(
            'James Kirk',
            'Jean-Luc Picard',
            'Benjamin Sisko',
            'Kathryn Janeway',
            'Jonathan Archer'
        )
        $answer = 2
        BeforeEach {
            mock Test-PollOptions { $true }
            mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = "True"
                    result = @{
                        message_id = 2222
                        from       = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                        chat       = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                        date       = "1530157540"
                        poll       = "@{id=4987907110399377412; question=What is your favorite Star Trek series?; options=System.Object[]; is_closed=False}"
                    }
                }
            }#endMock
        }#before_each
        Context 'Error' {
            It 'should return false if poll options do not meet Telegram requirements' {
                mock Test-PollOptions { $false }
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                }
                Send-TelegramPoll @sendTelegramPollSplat | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the poll' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                }
                Send-TelegramPoll @sendTelegramPollSplat | Should -Be $false
            }#it
            It 'should return false if a quiz type poll is sent without a quiz answer' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    PollType            = 'quiz'
                }
                Send-TelegramPoll @sendTelegramPollSplat | Should -Be $false
            }#it
            It 'should return false if a quiz type poll is sent with an out of bound quiz answer designator' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    PollType            = 'quiz'
                    QuizAnswer          = 11
                }
                Send-TelegramPoll @sendTelegramPollSplat | Should -Be $false
            }#it
        }#context_Error
        Context 'Success' {
            It 'should return expected results if successful with a typical poll' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    IsAnonymous         = $true
                    PollType            = 'regular'
                    DisableNotification = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be "True"
            }#it
            It 'should return expected results if successful with a quiz poll' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question2
                    Options             = $opt2
                    IsAnonymous         = $true
                    PollType            = 'quiz'
                    QuizAnswer          = $answer
                    DisableNotification = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be "True"
            }#it
        }#context_Success
    }#describe_Send-TelegramPoll
}#inModule