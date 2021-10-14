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
    Describe 'Test-BotToken' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $token = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
        } #before_each
        Context 'Error' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    throw 'Bullshit Error'
                } #endMock
                $testBotTokenSplat = @{
                    BotToken    = $token
                    ErrorAction = 'SilentlyContinue'
                }
                Test-BotToken @testBotTokenSplat | Should -Be $false
            } #it
        } #context_error
        Context 'Success' {
            It 'should return a custom PSCustomObject if successful' {
                Mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = 'True'
                        result = @{
                            id         = 2222
                            is_bot     = 'True'
                            first_name = 'botname'
                            username   = 'botname_bot'
                        }
                    }
                } #endMock
                $testBotTokenSplat = @{
                    BotToken = $token
                }
                Test-BotToken @testBotTokenSplat | Should -BeOfType System.Management.Automation.PSCustomObject
            } #it
        } #context_success
    } #describe_Test-BotToken
} #inModule
