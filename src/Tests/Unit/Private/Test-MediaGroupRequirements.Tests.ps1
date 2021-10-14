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
    Describe 'Test-MediaGroupRequirements' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock Test-Path { $true }
            Mock Test-FileExtension { $true }
            Mock Test-FileSize { $true }
            $justRight = @(
                'photo1.jpg',
                'photo2.jpg'
            )
        } #before_each

        It 'should return false if the files provided are fewer than 2' {
            $tooFew = @(
                'photo1.jpg'
            )
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Photo'
                FilePaths = $tooFew
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $false
        } #it

        It 'should return false if the files provided are great than 10' {
            $tooMany = @(
                'photo1.jpg',
                'photo2.jpg',
                'photo3.jpg',
                'photo4.jpg',
                'photo5.jpg',
                'photo6.jpg',
                'photo7.jpg',
                'photo8.jpg',
                'photo9.jpg',
                'photo10.jpg',
                'photo11.jpg'
            )
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Photo'
                FilePaths = $tooMany
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $false
        } #it

        It 'should return false if the media can not be found' {
            Mock Test-Path { $false }
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Photo'
                FilePaths = $justRight
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $false
        } #it

        It 'should return false if the media extension is not supported' {
            Mock Test-FileExtension { $false }
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Photo'
                FilePaths = $justRight
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $false
        } #it

        It 'should return false if the media is too large' {
            Mock Test-FileSize { $false }
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Video'
                FilePaths = $justRight
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $false
        } #it

        It 'should return true if all conditions are met' {
            $testMediaGroupRequirementsSplat = @{
                MediaType = 'Video'
                FilePaths = $justRight
            }
            Test-MediaGroupRequirements @testMediaGroupRequirementsSplat | Should -Be $true
        } #it

    } #describe
} #inModule
