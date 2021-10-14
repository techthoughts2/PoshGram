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
    Describe 'Send-TelegramURLDocument' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
            $chat = '-nnnnnnnnn'
            $fileURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip'
            Mock Test-URLExtension { $true }
            Mock Test-URLFileSize { $true }
            Mock Invoke-RestMethod -MockWith {
                [PSCustomObject]@{
                    ok     = 'True'
                    result = @{
                        message_id       = 2222
                        from             = '@{id=#########; is_bot=True; first_name=botname; username=bot_name}'
                        chat             = '@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}'
                        date             = '1530157540'
                        document         = '@{file_name=LogExample.zip; mime_type=application/zip;file_id=BQADBAADBgAD2j69UXHVUcgmhQqsAg; file_size=216}'
                        caption          = 'TechThoughts Logo'
                        caption_entities = '{@{offset=13; length=6; type=bold}}'
                    }
                }
            } #endMock
        } #before_each
        Context 'Error' {
            It 'should return false if the document extension is not supported' {
                Mock Test-URLExtension { $false }
                $sendTelegramURLDocumentSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    FileURL  = $fileURL
                    Caption  = 'TechThoughts Logo'
                }
                Send-TelegramURLDocument @sendTelegramURLDocumentSplat | Should -Be $false
            } #it

            It 'should return false if the file is too large' {
                Mock Test-URLFileSize { $false }
                $sendTelegramURLDocumentSplat = @{
                    BotToken = $token
                    ChatID   = $chat
                    FileURL  = $fileURL
                    Caption  = 'TechThoughts Logo'
                }
                Send-TelegramURLDocument @sendTelegramURLDocumentSplat | Should -Be $false
            } #it

            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $sendTelegramURLDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileURL             = $fileURL
                    Caption             = 'TechThoughts Logo'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                    ErrorAction         = 'SilentlyContinue'
                }
                Send-TelegramURLDocument @sendTelegramURLDocumentSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                $sendTelegramURLDocumentSplat = @{
                    BotToken            = $token
                    ChatID              = $chat
                    FileURL             = $fileURL
                    Caption             = 'TechThoughts Logo'
                    ParseMode           = 'MarkdownV2'
                    DisableNotification = $true
                }
                Send-TelegramURLDocument @sendTelegramURLDocumentSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Send-TelegramURLDocument
} #inModule
