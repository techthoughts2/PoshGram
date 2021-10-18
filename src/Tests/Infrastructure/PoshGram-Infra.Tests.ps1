#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'PoshGram'
#-------------------------------------------------------------------------
#if the module is already in memory, remove it
Get-Module PoshGram | Remove-Module -Force
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
InModuleScope PoshGram {
    Describe 'Infrastructure Tests' -Tag Infrastructure {
        BeforeAll {
            #$WarningPreference = 'SilentlyContinue'
            $latitude = 37.621313
            $longitude = -122.378955
            $phone = '1-222-222-2222'
            $firstName = 'Jean-Luc'
            $lastName = 'Picard'
            $title = 'Star Fleet Headquarters'
            $address = 'San Francisco, CA 94128'
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
            $sticker = 'CAADAgADwQADECECEGEtCrI_kALvFgQ'
            $photoURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/techthoughts.png"
            $fileURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/LogExample.zip"
            $videoURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/Intro.mp4"
            $audioURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
            $animationURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/jean.gif"
            $stickerURL = "https://s3-us-west-2.amazonaws.com/poshgram-url-tests/picard.webp"
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
            $row1 = @(
                @{
                    text = "`u{1F513} Unlock"
                }
                # @{
                #     text = 'button2'
                # }
            )
            $row2 = @(
                @{
                    text = "`u{1F512} Lock"
                }
                # @{
                #     text = 'button2'
                # }
            )
            $customKeyboard = @{
                keyboard          = @(
                    $row1,
                    $row2
                )
                one_time_keyboard = $true
            }
            #//////////////////////////////////////////////////////////////////////////
            # AWS Secrets manager retrieval - for use in AWS Codebuild deployment
            # ! this section will need to be commented out if you want to run locally
            # Import-Module AWS.Tools.SecretsManager
            # $s = Get-SECSecretValue -SecretId PoshGramTokens -Region us-west-2
            # $sObj = $s.SecretString | ConvertFrom-Json
            # $token = $sObj.PoshBotToken
            # $channel = $sObj.PoshChannel
            #//////////////////////////////////////////////////////////////////////////
            #referenced by AWS CodeBuild
            if ($PSVersionTable.Platform -eq 'Win32NT') {
                $file = "C:\Test\Photos\Photo.jpg"
                $file2 = "C:\Test\Documents\customlog.txt"
                $file7 = "C:\Test\Documents\customlog2.txt"
                $file3 = "C:\Test\Videos\Intro.mp4"
                $file4 = "C:\Test\Audio\Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
                $file6 = "C:\Test\Audio\TestAudio.mp3"
                $file5 = "C:\Test\Animation\jean.gif"
                $pPath = 'C:\Test\PhotoGroup'
                $pFiles = @(
                    "$pPath\picard.jpg",
                    "$pPath\riker.PNG",
                    "$pPath\data.jpg",
                    "$pPath\geordi.jpg",
                    "$pPath\troi.jpg",
                    "$pPath\beverly.jpg",
                    "$pPath\worf.jpg"
                )

                $vPath = 'C:\Test\VideoGroup'
                $vFiles = @(
                    "$vPath\first_contact.mp4",
                    "$vPath\root_beer.mp4"
                )
                $aFiles = @(
                    $file4,
                    $file6
                )
                $dFiles = @(
                    $file2,
                    $file7
                )
                $stickerFile = 'C:\Test\Stickers\picard.webp'
            } #if_windows
            elseif ($PSVersionTable.Platform -eq 'Unix') {
                $file = "/Test/Photos/Photo.jpg"
                $file2 = "/Test/Documents/customlog.txt"
                $file7 = "/Test/Documents/customlog2.txt"
                $file3 = "/Test/Videos/Intro.mp4"
                $file4 = "/Test/Audio/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
                $file6 = "/Test/Audio/TestAudio.mp3"
                $file5 = "/Test/Animation/jean.gif"
                $pPath = '/Test/PhotoGroup'
                $pFiles = @(
                    "$pPath/picard.jpg",
                    "$pPath/riker.PNG",
                    "$pPath/data.jpg",
                    "$pPath/geordi.jpg",
                    "$pPath/troi.jpg",
                    "$pPath/beverly.jpg",
                    "$pPath/worf.jpg"
                )

                $vPath = '/Test/VideoGroup'
                $vFiles = @(
                    "$vPath/first_contact.mp4",
                    "$vPath/root_beer.mp4"
                )
                $aFiles = @(
                    $file4,
                    $file6
                )
                $dFiles = @(
                    $file2,
                    $file7
                )
                $stickerFile = "/Test/Stickers/picard.webp"
            } #elseif_Linux
            else {
                throw
            } #else

        } #before_all

        BeforeEach {
            # ! these infra tests require pre-populated LOCAL files to run successfully
            # ! you must also provide the bot token and chat id for these tests to run
            #$token = ''
            #$channel = ''
        } #before_each

        Context 'Get-TelegramStickerPackInfo' {
            It 'Should return valid sticker pack information' {
                $getTelegramStickerPackInfoSplat = @{
                    StickerSetName = 'CookieMonster'
                    BotToken       = $token
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.set_name | Should -BeExactly 'CookieMonster'
            } #it
        } #context_Get-TelegramStickerPackInfo

        Context "Send-TelegramContact" {
            It 'Should return with ok:true when a contact is successfully sent' {
                $sendTelegramContactSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    PhoneNumber         = $phone
                    FirstName           = $firstName
                    LastName            = $lastName
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramContact @sendTelegramContactSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramContact

        Context 'Send-TelegramDice' {
            It 'Should return with ok:true when a dice is successfully sent' {
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Emoji               = 'dice'
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramDice @sendTelegramDiceSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramDice

        Context 'Send-TelegramLocalAnimation' {
            It 'Should return with ok:true when a local animation is successfully sent' {
                $sendTelegramLocalAnimationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AnimationPath       = $file5
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalAnimation</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalAnimation

        Context 'Send-TelegramLocalAudio' {
            It 'Should return with ok:true when a local audio message is successfully sent' {
                $sendTelegramLocalAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Audio               = $file4
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalAudio</b>"
                    Performer           = 'Tobu & Syndec'
                    Title               = 'Dusk'
                    FileName            = 'Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalAudio @sendTelegramLocalAudioSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalAudio

        Context 'Send-TelegramLocalDocument' {
            It 'Should return with ok:true when a local document message is successfully sent' {
                $sendTelegramLocalDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    File                = $file2
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalDocument</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalDocument

        Context 'Send-TelegramLocalPhoto' {
            It 'Should return with ok:true when a local photo message is successfully sent' {
                $sendTelegramLocalPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalPhoto</b>"
                    PhotoPath           = $file
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalPhoto

        Context 'Send-TelegramLocalSticker' {
            It 'Should return with ok:true when a local sticker message is successfully sent' {
                $sendTelegramLocalStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerPath         = $stickerFile
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalSticker

        Context 'Send-TelegramLocalVideo' {
            It 'Should return with ok:true when a local video message is successfully sent' {
                $sendTelegramLocalVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Video               = $file3
                    FileName            = 'Intro.mp4'
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalVideo</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalVideo

        Context 'Send-TelegramLocation' {
            It 'Should return with ok:true when a location is successfully sent' {
                $sendTelegramLocationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Longitude           = $longitude
                    Latitude            = $latitude
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramLocation @sendTelegramLocationSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocation

        Context 'Send-TelegramMediaGroup' {
            It 'Should return with ok:true when a group of photos is successfully sent' {
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Photo'
                    FilePaths           = $pFiles
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a group of videos is successfully sent' {
                Start-Sleep -Seconds 20
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Video'
                    FilePaths           = $vFiles
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a group of audios is successfully sent' {
                Start-Sleep -Seconds 30
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Audio'
                    FilePaths           = $aFiles
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a group of documents is successfully sent' {
                Start-Sleep -Seconds 20
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Document'
                    FilePaths           = $dFiles
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLAnimation

        Context 'Send-TelegramPoll' {
            It 'Should return with ok:true when a typical poll is successfully sent' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramPoll @sendTelegramPollSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a quiz poll is successfully sent' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Question            = $question2
                    Options             = $opt2
                    IsAnonymous         = $true
                    PollType            = 'quiz'
                    QuizAnswer          = $answer
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramPoll @sendTelegramPollSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a quiz poll is successfully sent with additional options' {
                $sendTelegramPollSplat = @{
                    BotToken             = $token
                    ChatID               = $channel
                    Question             = $question3
                    Options              = $opt2
                    Explanation          = $explanation
                    ExplanationParseMode = 'MarkdownV2'
                    IsAnonymous          = $false
                    PollType             = 'quiz'
                    QuizAnswer           = $answer
                    CloseDate            = (Get-Date).AddDays(1)
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramPoll @sendTelegramPollSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramPoll

        Context 'Send-TelegramSticker' {
            It 'Should return with ok:true when a sticker is sent by file_id' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    FileID              = $sticker
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramSticker @sendTelegramStickerSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'Should return with ok:true when a sticker is sent by sticker pack emoji shortcode' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerSetName      = 'STPicard'
                    Shortcode           = ':slightly_smiling_face:'
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramSticker @sendTelegramStickerSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramSticker

        Context 'Send-TelegramTextMessage' {
            It 'Should return with ok:true when a typical message is successfully sent' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    Message             = "I am a Pester test for <b>Send-TelegramTextMessage</b>"
                    ChatID              = $channel
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'should throw when a message is sent with markdown and characters are not properly escaped' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "I am a Pester test with special_characters not escaped"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }
                { Send-TelegramTextMessage @sendTelegramTextMessageSplat } | Should -Throw
            } #it

            It 'should return ok:true when a message is sent with markdown and characters are properly escaped' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "I am a Pester test with __special\_characters__ escaped properly\."
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'should return ok:true when a message is sent with an inline keyboard' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "Inline keyboard pester test\."
                    Keyboard            = $inlineKeyboard
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'should return ok:true when a message is sent with a custom keyboard' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "Custom keyboard pester test\."
                    Keyboard            = $customKeyboard
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

            It 'should return ok:true when a message is sent with properly formed emojis' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "`u{1F192} Sending emojis is cool\! `u{1F49B}"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it

        } #context_Send-TelegramTextMessage

        Context 'Send-TelegramURLAnimation' {
            It 'Should return with ok:true when a location is successfully sent' {
                $sendTelegramURLAnimationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AnimationURL        = $animationURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLAnimation</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLAnimation @sendTelegramURLAnimationSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLAnimation

        Context 'Send-TelegramURLAudio' {
            It 'Should return with ok:true when a URL audio message is successfully sent' {
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AudioURL            = $audioURL
                    Performer           = 'Tobu & Syndec'
                    Title               = 'Dusk'
                    FileName            = 'Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3'
                    Caption             = "I am a Pester test for <b>Send-TelegramURLAudio</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLAudio @sendTelegramURLAudioSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLAudio

        Context 'Send-TelegramURLDocument' {
            It 'Should return with ok:true when a URL document message is successfully sent' {
                Start-Sleep -Seconds 20
                $sendTelegramURLDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    FileURL             = $fileURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLDocument</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLDocument @sendTelegramURLDocumentSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLDocument

        Context 'Send-TelegramURLPhoto' {
            It 'Should return with ok:true when a photo url message is successfully sent' {
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Caption             = "I am a Pester test for <b>Send-TelegramURLPhoto</b>"
                    PhotoURL            = $photoURL
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramLocalPhoto

        Context 'Send-TelegramURLSticker' {
            It 'Should return with ok:true when a sticker by URL is successfully sent' {
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerURL          = $StickerURL
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLSticker @sendTelegramURLStickerSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLSticker

        Context 'Send-TelegramURLVideo' {
            It 'Should return with ok:true when a URL video message is successfully sent' {
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    VideoURL            = $videoURL
                    FileName            = 'Intro.mp4'
                    Caption             = "I am a Pester test for <b>Send-TelegramURLVideo</b>"
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramURLVideo @sendTelegramURLVideoSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramURLVideo

        Context 'Send-TelegramVenue' {
            It 'Should return with ok:true when a venue is successfully sent' {
                $sendTelegramVenueSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Title               = $title
                    Address             = $address
                    Longitude           = $longitude
                    Latitude            = $latitude
                    DisableNotification = $true
                }

                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Send-TelegramVenue @sendTelegramVenueSplat
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Send-TelegramVenue

        Context 'Test-BotToken' {
            It 'Should return with ok:true when a bot token is successfully validated' {
                $apiTest = $false
                $run = 0
                do {
                    $run++
                    $eval = $null
                    $backoffTime = $null
                    $eval = Test-BotToken -BotToken $token
                    if ($eval.error_code -eq 429) {
                        $backoffTime = $eval.parameters.retry_after + 15
                        Write-Warning ('Too many requests. Backing off for: {0}' -f $backoffTime)
                        Start-Sleep -Seconds $backoffTime
                    }
                    else {
                        $apiTest = $true
                    }
                } while ($apiTest -eq $false -and $run -le 3)

                $eval.ok | Should -Be 'True'
            } #it
        } #context_Test-BotToken

    } #describe_InfraTests
} #scope_PoshGram
