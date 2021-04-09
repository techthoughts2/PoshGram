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
$WarningPreference = 'SilentlyContinue'
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = 'SilentlyContinue'
    $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    #-------------------------------------------------------------------------
    Describe 'Test-BotToken' -Tag Unit {
        Context 'Error' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                $testBotTokenSplat = @{
                    BotToken    = $token
                    ErrorAction = 'SilentlyContinue'
                }
                Test-BotToken @testBotTokenSplat | Should -Be $false
            }#it
        }#context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = 'True'
                        result = @{
                            id         = 2222
                            is_bot     = 'True'
                            first_name = 'botname'
                            username   = 'botname_bot'
                        }
                    }
                }#endMock
                $testBotTokenSplat = @{
                    BotToken = $token
                }
                Test-BotToken @testBotTokenSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_success
    }#describe_Test-BotToken
}#inModule