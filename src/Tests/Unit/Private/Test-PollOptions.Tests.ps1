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
    function Write-Error {
    }
    #-------------------------------------------------------------------------
    Describe 'Test-PollOptions' -Tag Unit {
        It 'should return false if the number of options is below 2' {
            $opt = @(
                'One'
            )
            Test-PollOptions -PollOptions $opt | Should -Be $false
        }#it
        It 'should return false if the number of options is above 10' {
            $opt = @(
                'One',
                'Two',
                'Three',
                'Four',
                'Five',
                'Six',
                'Seven',
                'Eight',
                'Nine',
                'Ten',
                'Eleven'
            )
            Test-PollOptions -PollOptions $opt | Should -Be $false
        }#it
        It 'should return false if an option has a character count above 300' {
            $opt = @(
                'Three',
                'Four',
                'uhvfulonqhitqljlpyiziijocidwiljbjyezzkzmvcahymsppqpqrhxpcdqbaikjbkevsohjnjtdrmrvwoconbqeaemouzzpypeeguhvfulonqhitqljlpyiziijocidwiljbjyezzkzmvcahymsppqpqrhxpcdqbaikjbkevsohjnjtdrmrvwoconbqeaemouzzpypeeguhvfulonqhitqljlpyiziijocidwiljbjyezzkzmvcahymsppqpqrhxpcdqbaikjbkevsohjnjtdrmrvwoconbqeaemouzzpypeeg'
            )
            Test-PollOptions -PollOptions $opt | Should -Be $false
        }#it
        It 'should return true if a valid set of options is provided' {
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
            Test-PollOptions -PollOptions $opt | Should -Be $true
        }#it
    }#describe
}#inModule