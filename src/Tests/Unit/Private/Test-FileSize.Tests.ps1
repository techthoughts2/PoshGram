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
    Describe 'Test-FileSize' -Tag Unit {
        It 'Should return true when the file is at or below 50MB' {
            mock Get-ChildItem -MockWith {
                [PSCustomObject]@{
                    Mode          = "-a----"
                    LastWriteTime = "06/30/18     09:52"
                    Length        = "119136"
                    Name          = "techthoughts.png"
                }
            }#endMock
            Test-FileSize -Path "C:\videos\video.mp4" | Should -Be $true
        }#it
        It 'should return false when the file is over 50MB' {
            mock Get-ChildItem -MockWith {
                [PSCustomObject]@{
                    Mode          = "-a----"
                    LastWriteTime = "06/30/18     09:52"
                    Length        = "1593681272"
                    Name          = "techthoughts.png"
                }
            }#endMock
            Test-FileSize -Path "C:\videos\video.mp4" | Should -Be $false
        }#it
        It 'should return false when an error is encountered' {
            mock Get-ChildItem -MockWith {
                Throw 'Bullshit Error'
            }#endMock
            Test-FileSize -Path "C:\videos\video.mp4" | Should -Be $false
        }#it
    }#describe
}#inModule