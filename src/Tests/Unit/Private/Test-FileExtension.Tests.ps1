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
    $supportedPhotoExtensions = @(
        'JPG',
        'JPEG',
        'PNG',
        'GIF',
        'BMP',
        'WEBP',
        'SVG',
        'TIFF'
    )
    $supportedVideoExtensions = @(
        'mp4'
    )
    $supportedAudioExtensions = @(
        'mp3',
        'm4a'
    )
    $supportedAnimationExtensions = @(
        'GIF'
    )
    $supportedStickerExtensions = @(
        'WEBP',
        'TGS'
    )
    #-------------------------------------------------------------------------
    Describe 'Test-FileExtension' -Tag Unit {
        It 'should return false when a non-supported extension is provided' {
            Test-FileExtension -FilePath c:\fakepath\fakefile.txt `
                -Type Photo | Should -Be $false
            Test-FileExtension -FilePath c:\fakepath\fakefile.txt `
                -Type Video | Should -Be $false
            Test-FileExtension -FilePath c:\fakepath\fakefile.txt `
                -Type Audio | Should -Be $false
            Test-FileExtension -FilePath c:\fakepath\fakefile.txt `
                -Type Animation | Should -Be $false
            Test-FileExtension -FilePath c:\fakepath\fakefile.txt `
                -Type Sticker | Should -Be $false
        }#it
        Context 'Photo' {
            foreach ($extension in $supportedPhotoExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-FileExtension -FilePath c:\fakepath\fakefile.$extension `
                        -Type Photo | Should -Be $true
                }#it
            }#foreach
        }#context_Photo
        Context 'Video' {
            foreach ($extension in $supportedVideoExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-FileExtension -FilePath c:\fakepath\fakefile.$extension `
                        -Type Video | Should -Be $true
                }#it
            }#foreach
        }#context_Video
        Context 'Audio' {
            foreach ($extension in $supportedAudioExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-FileExtension -FilePath c:\fakepath\fakefile.$extension `
                        -Type Audio | Should -Be $true
                }#it
            }#foreach
        }#context_Audio
        Context 'Animation' {
            foreach ($extension in $supportedAnimationExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-FileExtension -FilePath c:\fakepath\fakefile.$extension `
                        -Type Animation | Should -Be $true
                }#it
            }#foreach
        }#context_Animation
        Context 'Animation' {
            foreach ($extension in $supportedStickerExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-FileExtension -FilePath c:\fakepath\fakefile.$extension `
                        -Type Sticker | Should -Be $true
                }#it
            }#foreach
        }#context_Animation
    }#describe
}#inModule