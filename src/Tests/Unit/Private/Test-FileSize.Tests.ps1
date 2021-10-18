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
    Describe 'Test-FileSize' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        It 'Should return true when the file is at or below 50MB' {
            Mock Get-ChildItem -MockWith {
                [PSCustomObject]@{
                    Mode          = '-a----'
                    LastWriteTime = '06/30/18     09:52'
                    Length        = '119136'
                    Name          = 'techthoughts.png'
                }
            } #endMock
            Test-FileSize -Path 'C:\videos\video.mp4' | Should -Be $true
        } #it
        It 'should return false when the file is over 50MB' {
            Mock Get-ChildItem -MockWith {
                [PSCustomObject]@{
                    Mode          = '-a----'
                    LastWriteTime = '06/30/18     09:52'
                    Length        = '1593681272'
                    Name          = 'techthoughts.png'
                }
            } #endMock
            Test-FileSize -Path 'C:\videos\video.mp4' | Should -Be $false
        } #it
        It 'should return false when an error is encountered' {
            Mock Get-ChildItem -MockWith {
                throw 'Fake Error'
            } #endMock
            Test-FileSize -Path 'C:\videos\video.mp4' | Should -Be $false
        } #it
    } #describe
} #inModule
