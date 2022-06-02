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
    Describe 'Send-TelegramPoll' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            $question = 'What is your favorite Star Trek series?'
            $opt = @(
                'Star Trek: The Original Series',
                'Star Trek: The Animated Series',
                'Star Trek: The Next Generation',
                'Star Trek: Deep Space Nine',
                'Star Trek: Voyager',
                'Star Trek: Enterprise',
                'Star Trek: Discovery',
                'Star Trek: Picard',
                'Star Trek: Lower Decks'
                'Star Trek: Prodigy'
            )
            $question2 = 'Who was the best Starfleet captain?'
            $opt2 = @(
                'James Kirk',
                'Jean-Luc Picard',
                'Benjamin Sisko',
                'Kathryn Janeway',
                'Jonathan Archer'
            )
            $answer = 1
            $question3 = 'Which Star Trek captain has an artificial heart?'
            $explanation = 'In _2327_, Jean\-Luc Picard received an *artificial heart* after he was stabbed by a Nausicaan during a bar brawl\.'
            Mock Test-PollOptions { $true }
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id = 2222
                        from       = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                        chat       = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                        date       = '1530157540'
                        poll       = '@{id=4987907110399377412; question=What is your favorite Star Trek series?; options=System.Object[]; is_closed=False}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should throw if poll options do not meet Telegram requirements' {
                Mock Test-PollOptions { $false }
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramPoll @sendTelegramPollSplat } | Should -Throw
            } #it

            It 'should throw if a quiz type poll is sent with an out of bound quiz answer designator' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                    PollType            = 'quiz'
                    QuizAnswer          = 11
                }
                { Send-TelegramPoll @sendTelegramPollSplat } | Should -Throw
            } #it

            It 'should throw if a quiz type poll has an explanation that does not meet requirements' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                    Explanation         = 'Space: the final frontier. These are the voyages of the starship Enterprise. Its five-year mission: to explore strange new worlds. To seek out new life and new civilizations. To boldly go where no man has gone before!'
                    PollType            = 'quiz'
                    QuizAnswer          = 1
                }
                { Send-TelegramPoll @sendTelegramPollSplat } | Should -Throw
            } #it

            It 'should throw if an error is encountered with no specific exception' {
                Mock Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramPoll @sendTelegramPollSplat } | Should -Throw
            } #it

            It 'should run the expected commands if an error is encountered' {
                Mock -CommandName Invoke-RestMethod {
                    throw 'Fake Error'
                } #endMock
                Mock -CommandName Write-Warning { }
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                { Send-TelegramPoll @sendTelegramPollSplat
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
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval.ok | Should -BeExactly 'False'
                $eval.error_code | Should -BeExactly '429'
            } #it
        } #context_Error
        Context 'Success' {
            It 'should call the API with the expected parameters' {
                Mock -CommandName Invoke-RestMethod {
                } -Verifiable -ParameterFilter { $Uri -like 'https://api.telegram.org/bot*sendPoll*' }
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    IsAnonymous         = $true
                    PollType            = 'regular'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                Send-TelegramPoll @sendTelegramPollSplat
                Assert-VerifiableMock
            } #it

            It 'should return expected results if successful with a typical poll' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    Question            = $question
                    Options             = $opt
                    IsAnonymous         = $true
                    PollType            = 'regular'
                    DisableNotification = $true
                    ProtectContent      = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be 'True'
            } #it

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
                    ProtectContent      = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be 'True'
            } #it

            It 'should return expected results if successfull with a quiz poll with additional options' {
                $sendTelegramPollSplat = @{
                    BotToken             = $token
                    ChatID               = $chat
                    Question             = $question3
                    Options              = $opt
                    Explanation          = $explanation
                    ExplanationParseMode = 'MarkdownV2'
                    IsAnonymous          = $false
                    PollType             = 'quiz'
                    QuizAnswer           = $answer
                    CloseDate            = (Get-Date).AddDays(1)
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be 'True'

                $sendTelegramPollSplat = @{
                    BotToken             = $token
                    ChatID               = $chat
                    Question             = $question3
                    Options              = $opt
                    Explanation          = $explanation
                    ExplanationParseMode = 'MarkdownV2'
                    IsAnonymous          = $false
                    PollType             = 'quiz'
                    QuizAnswer           = $answer
                    OpenPeriod           = 500
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval | Should -BeOfType System.Management.Automation.PSCustomObject
                $eval.ok | Should -Be 'True'
            } #it
        } #context_Success
    } #describe_Send-TelegramPoll
} #inModule
