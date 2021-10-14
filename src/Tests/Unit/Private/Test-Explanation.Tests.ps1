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

InModuleScope PoshGram {
    Describe 'Test-Explanation' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll

        It 'should return false if the explanation exceeds 200 characters' {
            $explanation = 'Space: the final frontier. These are the voyages of the starship Enterprise. Its five-year mission: to explore strange new worlds. To seek out new life and new civilizations. To boldly go where no man has gone before!'
            Test-Explanation -Explanation $explanation | Should -Be $false
        } #it

        It 'should return false if the explanation has more than 2 line feeds' {
            $explanation = @'
The Original Series
The Animated Series
The Next Generation
Deep Space Nine
Voyager
Enterprise
Discovery
Picard
Lower Decks
'@
            Test-Explanation -Explanation $explanation | Should -Be $false
        } #it

        It 'should return true if the explanation meets criteria' {
            $explanation = 'The Invincible-class is the single largest multi-mission combat-equipped starship ever constructed by Starfleet.'
            Test-Explanation -Explanation $explanation | Should -Be $true
        } #it

    } #describe
} #inModule
