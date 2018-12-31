#-------------------------------------------------------------------------
#if the module is already in memory, remove it
Get-Module PoshGram | Remove-Module -Force
#-------------------------------------------------------------------------
$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$moduleName = 'PoshGram.psd1'
$moduleNamePath = "$script:moduleRoot\$moduleName"

Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    #-------------------------------------------------------------------------
    ###########################################################################
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    #you MUST provide the following variables to complete infra tests
    <#
    $token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $file = "C:\Test\Photos\Photo.jpg"
    $file2 = "C:\Test\Documents\customlog.txt"
    $file3 = "C:\Test\Videos\Intro.mp4"
    $file4 = "C:\Test\Audio\Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
    #>
    $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip"
    $videoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Intro.mp4"
    $audioURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
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
                    -ChatID $chat `
                    -Message "I am a Pester test for *Send-TelegramTextMessage*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramTextMessage
        Context "Send-TelegramLocalPhoto" {
            It 'Should return with ok:true when a local photo message is successfully sent' {
                $eval = Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath $file `
                    -Caption "I am a Pester test for *Send-TelegramLocalPhoto*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLPhoto" {
            It 'Should return with ok:true when a photo url message is successfully sent' {
                $eval = Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoURL $photoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLPhoto*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramLocalDocument" {
            It 'Should return with ok:true when a local document message is successfully sent' {
                $eval = Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File $file2 `
                    -Caption "I am a Pester test for *Send-TelegramLocalDocument*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalPhoto
        Context "Send-TelegramURLDocument" {
            It 'Should return with ok:true when a URL document message is successfully sent' {
                $eval = Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -FileURL $fileURL `
                    -Caption "I am a Pester test for *Send-TelegramURLDocument*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLDocument
        Context "Send-TelegramLocalVideo" {
            It 'Should return with ok:true when a local video message is successfully sent' {
                $eval = Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video $file3 `
                    -Caption "I am a Pester test for *Send-TelegramLocalVideo*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalVideo
        Context "Send-TelegramURLVideo" {
            It 'Should return with ok:true when a URL video message is successfully sent' {
                $eval = Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -VideoURL $videoURL `
                    -Caption "I am a Pester test for *Send-TelegramURLVideo*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLVideo
        Context "Send-TelegramLocalAudio" {
            It 'Should return with ok:true when a local audio message is successfully sent' {
                $eval = Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio $file4 `
                    -Caption "I am a Pester test for *Send-TelegramLocalAudio*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramLocalAudio
        Context "Send-TelegramURLAudio" {
            It 'Should return with ok:true when a URL audio message is successfully sent' {
                $eval = Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -AudioURL $audioURL `
                    -Caption "I am a Pester test for *Send-TelegramURLAudio*"
                $eval.ok | Should -Be "True"
            }#it
        }#context_Send-TelegramURLAudio
    }#describe_InfraTests
}#scope_PoshGram