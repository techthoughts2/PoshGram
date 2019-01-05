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
    #you MUST provide the following variables to complete infra tests
    <#
    #$token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    #$channel = "-#########"
    $file = "C:\Test\Photos\Photo.jpg"
    $file2 = "C:\Test\Documents\customlog.txt"
    $file3 = "C:\Test\Videos\Intro.mp4"
    $file4 = "C:\Test\Audio\Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
    $file5 = "C:\Test\Animation\jean.gif"

    $path = 'C:\Test\PhotoGroup'
    $files = @(
        "$path\picard.jpg",
        "$path\riker.png",
        "$path\data.jpg",
        "$path\geordi.jpg",
        "$path\troi.jpg",
        "$path\beverly.jpg",
        "$path\worf.jpg"
    )

    $vPath = 'C:\Test\VideoGroup'
    $vFiles = @(
        "$vPath\first_contact.mp4",
        "$vPath\root_beer.mp4"
    )

    #>
    $latitude = 37.621313
    $longitude = -122.378955
    $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/src/Tests/SourceFiles/techthoughts.png"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/src/Tests/SourceFiles/LogExample.zip"
    $videoURL = "https://github.com/techthoughts2/PoshGram/raw/master/src/Tests/SourceFiles/Intro.mp4"
    $audioURL = "https://github.com/techthoughts2/PoshGram/raw/master/src/Tests/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
    $animationURL = "https://github.com/techthoughts2/PoshGram/raw/master/src/Tests/SourceFiles/jean.gif"
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
                    -Message "I am a Pester test for *Send-TelegramTextMessage*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramTextMessage
        Context "Send-TelegramLocalPhoto" {
            It 'Should return with ok:true when a local photo message is successfully sent' {
                $eval = Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $channel `
                    -PhotoPath $file `
                    -Caption "I am a Pester test for *Send-TelegramLocalPhoto*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLPhoto" {
            It 'Should return with ok:true when a photo url message is successfully sent' {
                $eval = Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $channel `
                    -PhotoURL $photoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLPhoto*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramLocalDocument" {
            It 'Should return with ok:true when a local document message is successfully sent' {
                $eval = Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $channel `
                    -File $file2 `
                    -Caption "I am a Pester test for *Send-TelegramLocalDocument*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLDocument" {
            It 'Should return with ok:true when a URL document message is successfully sent' {
                $eval = Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $channel `
                    -FileURL $fileURL `
                    -Caption "I am a Pester test for *Send-TelegramURLDocument*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLDocument
        Context "Send-TelegramLocalVideo" {
            It 'Should return with ok:true when a local video message is successfully sent' {
                $eval = Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $channel `
                    -Video $file3 `
                    -Caption "I am a Pester test for *Send-TelegramLocalVideo*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalVideo
        Context "Send-TelegramURLVideo" {
            It 'Should return with ok:true when a URL video message is successfully sent' {
                $eval = Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $channel `
                    -VideoURL $videoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLVideo*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLVideo
        Context "Send-TelegramLocalAudio" {
            It 'Should return with ok:true when a local audio message is successfully sent' {
                $eval = Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $channel `
                    -Audio $file4 `
                    -Caption "I am a Pester test for *Send-TelegramLocalAudio*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAudio
        Context "Send-TelegramURLAudio" {
            It 'Should return with ok:true when a URL audio message is successfully sent' {
                $eval = Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $channel `
                    -AudioURL $audioURL `
                    -Caption "I am a Pester test for *Send-TelegramURLAudio*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAudio
        Context "Send-TelegramLocation" {
            It 'Should return with ok:true when a location is successfully sent' {
                $eval = Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $channel `
                    -Latitude $latitude `
                    -Longitude $longitude
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocation
        Context "Send-TelegramLocalAnimation" {
            It 'Should return with ok:true when a local animation is successfully sent' {
                $eval = Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $channel `
                    -AnimationPath $file5 `
                    -Caption "I am a Pester test for *Send-TelegramLocalAnimation*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAnimation
        Context "Send-TelegramURLAnimation" {
            It 'Should return with ok:true when a location is successfully sent' {
                $eval = Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $channel `
                    -AnimationURL $animationURL `
                    -Caption "I am a Pester test for *Send-TelegramURLAnimation*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
        Context "Send-TelegramMediaGroup" {
            It 'Should return with ok:true when a group of photos is successfully sent' {
                $eval = Send-TelegramMediaGroup `
                    -BotToken $token `
                    -ChatID $channel `
                    -MediaType Photo `
                    -FilePaths $files
                $eval.ok | Should -Be "True"
            }#it
            It 'Should return with ok:true when a group of videos is successfully sent' {
                $eval = Send-TelegramMediaGroup `
                    -BotToken $token `
                    -ChatID $channel `
                    -MediaType Video `
                    -FilePaths $vFiles
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAnimation
    }#describe_InfraTests
}#scope_PoshGram