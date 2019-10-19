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
    Describe 'Send-TelegramContact' -Tag Unit {
        $phone = '1-222-222-2222'
        $firstName = 'Jake'
        $lastName = 'Morrison'
        Context 'Error' {
            It 'should return false if an error is encountered sending the contact' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramContact `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhoneNumber $phone `
                    -FirstName $firstName `
                    -LastName $lastName `
                    -DisableNotification `
                    | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            contact          = "@{phone_number=12222222222; first_name=Jake}"
                        }
                    }
                }#endMock
                Send-TelegramContact `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhoneNumber $phone `
                    -FirstName $firstName `
                    -LastName $lastName `
                    -DisableNotification `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Send-TelegramContact
}#inModule