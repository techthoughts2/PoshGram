#-------------------------------------------------------------------------
#if the module is already in memory, remove it
Get-Module PoshGram | Remove-Module -Force
#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot

$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")

if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    #-------------------------------------------------------------------------
    ###########################################################################
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    <#
         _______.___________.  ______   .______
        /       |           | /  __  \  |   _  \
       |   (----`---|  |----`|  |  |  | |  |_)  |
        \   \       |  |     |  |  |  | |   ___/
    .----)   |      |  |     |  `--'  | |  |
    |_______/       |__|      \______/  | _|

    #>
    #these infra tests require pre-populated LOCAL files to run successfully
    #you must also provide the bot token and chat id for these tests to run
    #$token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    #$chat = "-nnnnnnnnn"
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ###########################################################################
    #>
    $latitude = 37.621313
    $longitude = -122.378955
    # $phone = '1-222-222-2222'
    # $firstName = 'Jean-Luc'
    # $lastName = 'Picard'
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
    #//////////////////////////////////////////////////////////////////////////
    # AWS Secrets manager retrieval - for use in AWS Codebuild deployment
    # this section will need to be commented out if you want to run locally
    Import-Module AWS.Tools.SecretsManager
    $s = Get-SECSecretValue -SecretId PoshGramTokens -Region us-west-2
    $sObj = $s.SecretString | ConvertFrom-Json
    $token = $sObj.PoshBotToken
    $channel = $sObj.PoshChannel
    #//////////////////////////////////////////////////////////////////////////
    #referenced by AWS CodeBuild
    if ($PSVersionTable.Platform -eq 'Win32NT') {
        $file = "C:\Test\Photos\Photo.jpg"
        $file2 = "C:\Test\Documents\customlog.txt"
        $file3 = "C:\Test\Videos\Intro.mp4"
        $file4 = "C:\Test\Audio\Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
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
        $stickerFile = 'C:\Test\Stickers\picard.webp'
    }#if_windows
    elseif ($PSVersionTable.Platform -eq 'Unix') {
        $file = "/Test/Photos/Photo.jpg"
        $file2 = "/Test/Documents/customlog.txt"
        $file3 = "/Test/Videos/Intro.mp4"
        $file4 = "/Test/Audio/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
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
        $stickerFile = "/Test/Stickers/picard.webp"
    }#elseif_Linux
    else {
        throw
    }#else
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    ###########################################################################
    Describe 'Infrastructure Tests' -Tag Infrastructure {
        $milliSeconds = 15000
        Context 'Test-BotToken' {
            It 'Should return with ok:true when a bot token is successfully validated' {
                $eval = Test-BotToken -BotToken $token
                $eval.ok | Should -Be "True"
            }#it
        }#context_Test-BotToken
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramTextMessage' {
            It 'Should return with ok:true when a typical message is successfully sent' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    Message             = "I am a Pester test for <b>Send-TelegramTextMessage</b>"
                    ChatID              = $channel
                    DisableNotification = $true
                }
                $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                $eval.ok | Should -Be "True"
            }#it
            Start-Sleep -Milliseconds $milliSeconds
            It 'should throw when a message is sent with markdown and characters are not properly escaped' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "I am a Pester test with special_characters not escaped"
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }
                { Send-TelegramTextMessage @sendTelegramTextMessageSplat } | Should Throw
            }#it
            Start-Sleep -Milliseconds $milliSeconds
            It 'should return ok:true when a message is sent with markdown and characters are properly escaped' {
                $sendTelegramTextMessageSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Message             = "I am a Pester test with __special\_characters__ escaped properly\."
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'Stop'
                }
                $eval = Send-TelegramTextMessage @sendTelegramTextMessageSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramTextMessage
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalPhoto' {
            It 'Should return with ok:true when a local photo message is successfully sent' {
                $sendTelegramLocalPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalPhoto</b>"
                    PhotoPath           = $file
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLPhoto' {
            It 'Should return with ok:true when a photo url message is successfully sent' {
                $sendTelegramURLPhotoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Caption             = "I am a Pester test for <b>Send-TelegramURLPhoto</b>"
                    PhotoURL            = $photoURL
                    DisableNotification = $true
                }
                $eval = Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalDocument' {
            It 'Should return with ok:true when a local document message is successfully sent' {
                $sendTelegramLocalDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    File                = $file2
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalDocument</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocalDocument @sendTelegramLocalDocumentSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLDocument' {
            It 'Should return with ok:true when a URL document message is successfully sent' {
                $sendTelegramURLDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    FileURL             = $fileURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLDocument</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramURLDocument @sendTelegramURLDocumentSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLDocument
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalVideo' {
            It 'Should return with ok:true when a local video message is successfully sent' {
                $sendTelegramLocalVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Video               = $file3
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalVideo</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocalVideo @sendTelegramLocalVideoSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalVideo
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLVideo' {
            It 'Should return with ok:true when a URL video message is successfully sent' {
                $sendTelegramURLVideoSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    VideoURL            = $videoURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLVideo</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramURLVideo @sendTelegramURLVideoSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLVideo
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalAudio' {
            It 'Should return with ok:true when a local audio message is successfully sent' {
                $sendTelegramLocalAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Audio               = $file4
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalAudio</b>"
                    DisableNotification = $true
                }

                $eval = Send-TelegramLocalAudio @sendTelegramLocalAudioSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAudio
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLAudio' {
            It 'Should return with ok:true when a URL audio message is successfully sent' {
                $sendTelegramURLAudioSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AudioURL            = $audioURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLAudio</b>"
                    DisableNotification = $true
                }

                $eval = Send-TelegramURLAudio @sendTelegramURLAudioSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAudio
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocation' {
            It 'Should return with ok:true when a location is successfully sent' {
                $sendTelegramLocationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Longitude           = $longitude
                    Latitude            = $latitude
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocation @sendTelegramLocationSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocation
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalAnimation' {
            It 'Should return with ok:true when a local animation is successfully sent' {
                $sendTelegramLocalAnimationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AnimationPath       = $file5
                    Caption             = "I am a Pester test for <b>Send-TelegramLocalAnimation</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAnimation
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLAnimation' {
            It 'Should return with ok:true when a location is successfully sent' {
                $sendTelegramURLAnimationSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    AnimationURL        = $animationURL
                    Caption             = "I am a Pester test for <b>Send-TelegramURLAnimation</b>"
                    DisableNotification = $true
                }
                $eval = Send-TelegramURLAnimation @sendTelegramURLAnimationSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramMediaGroup' {
            It 'Should return with ok:true when a group of photos is successfully sent' {
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Photo'
                    FilePaths           = $pFiles
                    DisableNotification = $true
                }
                $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                $eval.ok | Should -Be "True"
            }#it
            Start-Sleep -Seconds 10
            It 'Should return with ok:true when a group of videos is successfully sent' {
                $sendTelegramMediaGroupSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    MediaType           = 'Video'
                    FilePaths           = $vFiles
                    DisableNotification = $true
                }
                $eval = Send-TelegramMediaGroup @sendTelegramMediaGroupSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
        Start-Sleep -Milliseconds $milliSeconds
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
                $eval = Send-TelegramContact @sendTelegramContactSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramContact
        Start-Sleep -Milliseconds $milliSeconds
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
                $eval = Send-TelegramVenue @sendTelegramVenueSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramVenue
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramPoll' {
            It 'Should return with ok:true when a typical poll is successfully sent' {
                $sendTelegramPollSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Question            = $question
                    Options             = $opt
                    DisableNotification = $true
                }
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval.ok | Should -Be "True"
            }#it
            Start-Sleep -Milliseconds $milliSeconds
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
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval.ok | Should -Be "True"
            }#it
            Start-Sleep -Milliseconds $milliSeconds
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
                $eval = Send-TelegramPoll @sendTelegramPollSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramPoll
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Get-TelegramStickerPackInfo' {
            It 'Should return valid sticker pack information' {
                $getTelegramStickerPackInfoSplat = @{
                    StickerSetName = 'CookieMonster'
                    BotToken       = $token
                }

                $eval = Get-TelegramStickerPackInfo @getTelegramStickerPackInfoSplat
                $eval.set_name | Should -BeExactly 'CookieMonster'
            }#it
        }#context_Get-TelegramStickerPackInfo
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramSticker' {
            It 'Should return with ok:true when a sticker is sent by file_id' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    FileID              = $sticker
                    DisableNotification = $true
                }
                $eval = Send-TelegramSticker @sendTelegramStickerSplat
                $eval.ok | Should -Be "True"
            }#it
            Start-Sleep -Milliseconds $milliSeconds
            It 'Should return with ok:true when a sticker is sent by sticker pack emoji shortcode' {
                $sendTelegramStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerSetName      = 'STPicard'
                    Shortcode           = ':slightly_smiling_face:'
                    DisableNotification = $true
                }
                $eval = Send-TelegramSticker @sendTelegramStickerSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramSticker
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramLocalSticker' {
            It 'Should return with ok:true when a local sticker message is successfully sent' {
                $sendTelegramLocalStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerPath         = $stickerFile
                    DisableNotification = $true
                }
                $eval = Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalSticker
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramURLSticker' {
            It 'Should return with ok:true when a sticker by URL is successfully sent' {
                $sendTelegramURLStickerSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    StickerURL          = $StickerURL
                    DisableNotification = $true
                }
                $eval = Send-TelegramURLSticker @sendTelegramURLStickerSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLSticker
        Start-Sleep -Milliseconds $milliSeconds
        Context 'Send-TelegramDice' {
            It 'Should return with ok:true when a dice is successfully sent' {
                $sendTelegramDiceSplat = @{
                    BotToken            = $token
                    ChatID              = $channel
                    Emoji               = 'dice'
                    DisableNotification = $true
                }
                $eval = Send-TelegramDice @sendTelegramDiceSplat
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramDice
    }#describe_InfraTests
}#scope_PoshGram