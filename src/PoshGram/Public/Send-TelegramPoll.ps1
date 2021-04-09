<#
.Synopsis
    Sends Telegram native poll.
.DESCRIPTION
    Uses Telegram Bot API to send a native poll with a question and several answer options.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
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
    )
    Send-TelegramPoll -BotToken $botToken -ChatID $chat -Question $question -Options $opt

    Sends poll via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $question = 'Who is your favorite Star Fleet Captain?'
    $opt = 'Jean-Luc Picard','Jean-Luc Picard','Jean-Luc Picard'
    $sendTelegramPollSplat = @{
        BotToken            = $token
        ChatID              = $chat
        Question            = $question
        Options             = $opt
        DisableNotification = $true
        IsAnonymous         = $true
        PollType            = 'regular'
        MultipleAnswers     = $false
    }
    Send-TelegramPoll @sendTelegramPollSplat

    Sends poll via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $question = 'Who was the best Starfleet captain?'
    $opt = @(
        'James Kirk',
        'Jean-Luc Picard',
        'Benjamin Sisko',
        'Kathryn Janeway',
        'Jonathan Archer'
    )
    $answer = 1
    $sendTelegramPollSplat = @{
        BotToken    = $botToken
        ChatID      = $chat
        Question    = $question
        Options     = $opt
        IsAnonymous = $false
        PollType    = 'quiz'
        QuizAnswer  = $answer
    }
    Send-TelegramPoll @sendTelegramPollSplat

    Sends quiz via Telegram API
.EXAMPLE
    $question = 'Which class is the largest starship constructed by Starfleet?'
    $opt = @(
        'Constitution class',
        'Intrepid class',
        'California class',
        'Galaxy class',
        'Invincible class',
        'Sovereign class',
        'Excelsior class',
        'Miranda class',
        'Nebula class',
        'Olympic class'
    )
    $explanation = 'At 1,607.2 meters in length, 764.4 meters across, and 305.76 meters high, Invincible class is the largest starship class ever built by Starfleet.'
    $answer = 4
    $sendTelegramPollSplat = @{
        BotToken    = $token
        ChatID      = $channel
        Question    = $question
        Options     = $opt
        Explanation = $explanation
        IsAnonymous = $false
        PollType    = 'quiz'
        QuizAnswer  = $answer
    }
    Send-TelegramPoll @sendTelegramPollSplat

    Sends quiz via Telegram API with answer explanation.
.EXAMPLE
    $question = 'Which Star Trek captain has an artificial heart?'
    $opt = @(
        'James Kirk',
        'Jean-Luc Picard',
        'Benjamin Sisko',
        'Kathryn Janeway',
        'Jonathan Archer'
    )
    $explanation = 'In _2327_, Jean\-Luc Picard received an *artificial heart* after he was stabbed by a Nausicaan during a bar brawl\.'
    $answer = 1
    $sendTelegramPollSplat = @{
        BotToken             = $token
        ChatID               = $channel
        Question             = $question
        Options              = $opt
        Explanation          = $explanation
        ExplanationParseMode = 'MarkdownV2'
        IsAnonymous          = $false
        PollType             = 'quiz'
        QuizAnswer           = $answer
        CloseDate            = (Get-Date).AddDays(1)
    }
    Send-TelegramPoll @sendTelegramPollSplat

    Sends quiz via Telegram API with answer explanation properly formatted in MarkdownV2. Quiz will be open for 24 hours (1 day).
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Question
    Poll question
.PARAMETER Options
    String array of answer options
.PARAMETER IsAnonymous
    True, if the poll needs to be anonymous, defaults to True
.PARAMETER PollType
    Poll type, “quiz” or “regular”, defaults to “regular”
.PARAMETER MultipleAnswers
    True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
.PARAMETER QuizAnswer
    0-based identifier of the correct answer option, required for polls in quiz mode
.PARAMETER Explanation
    Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing
.PARAMETER ExplanationParseMode
    HTML vs Markdown for explanation formatting - HTML by default - https://core.telegram.org/bots/api#formatting-options
.PARAMETER OpenPeriod
    Amount of time in seconds the poll will be active after creation, 5-600.
.PARAMETER CloseDate
    Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future.
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather

    Telegram currently supports questions 1-300 characters
    Telegram currently supports 2-10 options 1-100 characters each
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    question                String                  Yes         Poll question, 1-255 characters
    options                 Array of String         Yes         List of answer options, 2-10 strings 1-100 characters each
    is_anonymous            Boolean                 Optional    True, if the poll needs to be anonymous, defaults to True
    type                    String                  Optional    Poll type, “quiz” or “regular”, defaults to “regular”
    allows_multiple_answers Boolean                 Optional    True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
    correct_option_id       Integer                 Optional    0-based identifier of the correct answer option, required for polls in quiz mode
    explanation             String                  Optional    Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing
    explanation_parse_mode  String                  Optional    Mode for parsing entities in the explanation.
    open_period             Integer                 Optional    Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with close_date.
    close_date              Integer                 Optional    Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramPoll.md
.LINK
    https://core.telegram.org/bots/api#sendpoll
#>
function Send-TelegramPoll {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted

        [Parameter(Mandatory = $true,
            HelpMessage = 'Poll question')]
        [ValidateLength(1, 300)]
        [string]$Question,

        [Parameter(Mandatory = $true,
            HelpMessage = 'String array of answer options')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Options,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Set the poll to be anonymous or not')]
        [bool]$IsAnonymous = $true, #default is anonymous

        [Parameter(Mandatory = $false,
            HelpMessage = 'Poll Type')]
        [ValidateSet('quiz', 'regular')]
        [string]$PollType = 'regular', #default is regular

        [Parameter(Mandatory = $false,
            HelpMessage = 'Poll allows multiple answers - ignored in quiz mode')]
        [bool]$MultipleAnswers = $false, #default is false

        [Parameter(Mandatory = $false,
            HelpMessage = 'Quiz answer designator')]
        [int]$QuizAnswer,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Text that is shown when a user chooses an incorrect answer')]
        [string]$Explanation,

        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for explanation formatting')]
        [ValidateSet('Markdown', 'MarkdownV2', 'HTML')]
        [string]$ExplanationParseMode = 'HTML', #set to HTML by default

        [Parameter(ParameterSetName = 'OpenPeriod',
            Mandatory = $false,
            HelpMessage = 'Time in seconds the poll/quiz will be active after creation')]
        [ValidateRange(5, 600)]
        [int]$OpenPeriod,

        [Parameter(ParameterSetName = 'OpenDate',
            Mandatory = $false,
            HelpMessage = 'Point in time when the poll will be automatically closed.')]
        [datetime]$CloseDate,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $optionEval = Test-PollOptions -PollOptions $Options
    if ($optionEval -eq $false) {
        $results = $false
        return $results
    }
    #------------------------------------------------------------------------
    $Options = $Options | ConvertTo-Json
    $uri = "https://api.telegram.org/bot$BotToken/sendPoll"
    $Form = @{
        chat_id                 = $ChatID
        question                = $Question
        disable_notification    = $DisableNotification.IsPresent
        options                 = $Options
        is_anonymous            = $IsAnonymous
        type                    = $PollType
        allows_multiple_answers = $MultipleAnswers
    }#form
    #------------------------------------------------------------------------
    if ($PollType -eq 'quiz') {
        if ($null -eq $QuizAnswer -or $QuizAnswer -lt 1 -or $QuizAnswer -gt 10) {
            Write-Warning -Message 'When PollType is quiz, you must supply a QuizAnswer desginator.'
            $results = $false
            return $results
        }
        else {
            $Form += @{correct_option_id = $QuizAnswer }

            if ($Explanation) {
                $explanationEval = Test-Explanation -Explanation $Explanation
                if ($explanationEval -eq $false) {
                    $results = $false
                    return $results
                }
                $Form += @{explanation = $Explanation }
                $Form += @{explanation_parse_mode = $ExplanationParseMode }
            }
        }
    }
    #------------------------------------------------------------------------
    if ($OpenPeriod) {
        $Form += @{open_period = $OpenPeriod }
    }
    if ($CloseDate) {
        $Form += @{close_date = (New-TimeSpan -Start (Get-Date) -End $CloseDate).TotalSeconds }
    }
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = $Uri
        ErrorAction = 'Stop'
        Form        = $Form
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    }#try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram poll:'
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramPoll
