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
        'Star Trek: Picard'
    )
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
    Import-Module AWSPowerShell.NetCore
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
    else{
        throw
    }#else
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    ###########################################################################
    Describe 'Infrastructure Tests' -Tag Infrastructure {
        Context "Test-BotToken" {
            It 'Should return with ok:true when a bot token is successfully validated' {
                $eval = Test-BotToken -BotToken $token
                $eval.ok | Should -Be "True"
            }#it
        }#context_Test-BotToken
        Context "Send-TelegramTextMessage" {
            It 'Should return with ok:true when a message is successfully sent' {
                $eval = Send-TelegramTextMessage `
                    -BotToken $token `
                    -ChatID $channel `
                    -Message "I am a Pester test for *Send-TelegramTextMessage*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramTextMessage
        Context "Send-TelegramLocalPhoto" {
            It 'Should return with ok:true when a local photo message is successfully sent' {
                $eval = Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $channel `
                    -PhotoPath $file `
                    -Caption "I am a Pester test for *Send-TelegramLocalPhoto*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLPhoto" {
            It 'Should return with ok:true when a photo url message is successfully sent' {
                $eval = Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $channel `
                    -PhotoURL $photoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLPhoto*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramLocalDocument" {
            It 'Should return with ok:true when a local document message is successfully sent' {
                $eval = Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $channel `
                    -File $file2 `
                    -Caption "I am a Pester test for *Send-TelegramLocalDocument*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLDocument" {
            It 'Should return with ok:true when a URL document message is successfully sent' {
                $eval = Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $channel `
                    -FileURL $fileURL `
                    -Caption "I am a Pester test for *Send-TelegramURLDocument*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLDocument
        Context "Send-TelegramLocalVideo" {
            It 'Should return with ok:true when a local video message is successfully sent' {
                $eval = Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $channel `
                    -Video $file3 `
                    -Caption "I am a Pester test for *Send-TelegramLocalVideo*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalVideo
        Context "Send-TelegramURLVideo" {
            It 'Should return with ok:true when a URL video message is successfully sent' {
                $eval = Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $channel `
                    -VideoURL $videoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLVideo*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLVideo
        Context "Send-TelegramLocalAudio" {
            It 'Should return with ok:true when a local audio message is successfully sent' {
                $eval = Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $channel `
                    -Audio $file4 `
                    -Caption "I am a Pester test for *Send-TelegramLocalAudio*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAudio
        Context "Send-TelegramURLAudio" {
            It 'Should return with ok:true when a URL audio message is successfully sent' {
                $eval = Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $channel `
                    -AudioURL $audioURL `
                    -Caption "I am a Pester test for *Send-TelegramURLAudio*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAudio
        Context "Send-TelegramLocation" {
            It 'Should return with ok:true when a location is successfully sent' {
                $eval = Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $channel `
                    -Latitude $latitude `
                    -Longitude $longitude `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocation
        Context "Send-TelegramLocalAnimation" {
            It 'Should return with ok:true when a local animation is successfully sent' {
                $eval = Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $channel `
                    -AnimationPath $file5 `
                    -Caption "I am a Pester test for *Send-TelegramLocalAnimation*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAnimation
        Context "Send-TelegramURLAnimation" {
            It 'Should return with ok:true when a location is successfully sent' {
                $eval = Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $channel `
                    -AnimationURL $animationURL `
                    -Caption "I am a Pester test for *Send-TelegramURLAnimation*" `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
        Context "Send-TelegramMediaGroup" {
            It 'Should return with ok:true when a group of photos is successfully sent' {
                $eval = Send-TelegramMediaGroup `
                    -BotToken $token `
                    -ChatID $channel `
                    -MediaType Photo `
                    -FilePaths $pFiles `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
            It 'Should return with ok:true when a group of videos is successfully sent' {
                $eval = Send-TelegramMediaGroup `
                    -BotToken $token `
                    -ChatID $channel `
                    -MediaType Video `
                    -FilePaths $vFiles `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
        # Commenting as this API call has a low limit which sometimes results in failed builds
        # Context "Send-TelegramContact" {
        #     It 'Should return with ok:true when a contact is successfully sent' {
        #         $eval = Send-TelegramContact `
        #             -BotToken $token `
        #             -ChatID $channel `
        #             -PhoneNumber $phone `
        #             -FirstName $firstName `
        #             -LastName $lastName `
        #             -DisableNotification
        #         $eval.ok | Should -Be "True"
        #     }#it
        # }#context_Send-TelegramContact
        Context "Send-TelegramVenue" {
            It 'Should return with ok:true when a venue is successfully sent' {
                $eval = Send-TelegramVenue `
                    -BotToken $token `
                    -ChatID $channel `
                    -Latitude $latitude `
                    -Longitude $longitude `
                    -Title $title `
                    -Address $address `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramVenue
        Context "Send-TelegramPoll" {
            It 'Should return with ok:true when a poll is successfully sent' {
                $eval = Send-TelegramPoll `
                    -BotToken $token `
                    -ChatID $channel `
                    -Question $question `
                    -Options $opt `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramPoll
        Context "Get-TelegramStickerPackInfo" {
            It 'Should return valid sticker pack information' {
                $eval = Get-TelegramStickerPackInfo `
                    -BotToken $token `
                    -StickerSetName CookieMonster
                $eval.set_name | Should -BeExactly 'CookieMonster'
            }#it
        }#context_Get-TelegramStickerPackInfo
        Context "Send-TelegramSticker" {
            It 'Should return with ok:true when a sticker is sent by file_id' {
                $eval = Send-TelegramSticker `
                    -BotToken $token `
                    -ChatID $channel `
                    -FileID $sticker `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
            It 'Should return with ok:true when a sticker is sent by sticker pack emoji shortcode' {
                $eval = Send-TelegramSticker `
                    -BotToken $token `
                    -ChatID $channel `
                    -StickerSetName STPicard `
                    -Shortcode ':slightly_smiling_face:' `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramSticker
        Context "Send-TelegramLocalSticker" {
            It 'Should return with ok:true when a local sticker message is successfully sent' {
                $eval = Send-TelegramLocalSticker `
                    -BotToken $token `
                    -ChatID $channel `
                    -StickerPath $stickerFile `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalSticker
        Context "Send-TelegramURLSticker" {
            It 'Should return with ok:true when a sticker by URL is successfully sent' {
                $eval = Send-TelegramURLSticker `
                    -BotToken $token `
                    -ChatID $channel `
                    -StickerURL $StickerURL `
                    -DisableNotification
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLSticker
    }#describe_InfraTests
}#scope_PoshGram