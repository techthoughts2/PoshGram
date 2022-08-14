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
    Describe 'Test-URLExtension' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            Mock Confirm-Url -MockWith {
                $true
            } #endmock
            Mock Resolve-ShortLink {}
            $animationURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/jean.gif'
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
            $supportedDocumentExtensions = @(
                'PDF',
                'GIF',
                'ZIP'
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
                'WEBP'
                'WEBM'
                # 'TGS'
            )
            #-------------------------------------------------------------------------
        } #before_each

        It 'should return false when a non-supported extension is provided' {
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Photo | Should -Be $false
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Video | Should -Be $false
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Audio | Should -Be $false
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Animation | Should -Be $false
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Document | Should -Be $false
            Test-URLExtension -URL 'https://www.techthoughts.info/file.xml' `
                -Type Sticker | Should -Be $false
        } #it

        Context 'Photo' {
            foreach ($extension in $supportedPhotoExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Photo | Should -Be $true
                } #it
            } #foreach
        } #context_Photo

        Context 'Video' {
            foreach ($extension in $supportedVideoExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Video | Should -Be $true
                } #it
            } #foreach
        } #context_Video

        Context 'Audio' {
            foreach ($extension in $supportedAudioExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Audio | Should -Be $true
                } #it
            } #foreach
        } #context_Audio

        Context 'Animation' {
            foreach ($extension in $supportedAnimationExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Animation | Should -Be $true
                } #it
            } #foreach
        } #context_Animation

        Context 'Document' {
            foreach ($extension in $supportedDocumentExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Document | Should -Be $true
                } #it
            } #foreach
        } #context_Document

        Context 'Sticker' {
            foreach ($extension in $supportedStickerExtensions) {
                It "should return true when $extension extension is provided" {
                    Test-URLExtension -URL "https://www.techthoughts.info/file.$extension" `
                        -Type Sticker | Should -Be $true
                } #it
            } #foreach
        } #context_Sticker

        It 'should properly resolve an extension after a shortlink is resolved' {
            Mock Confirm-Url -MockWith {
                $true
            } #endmock
            Mock Resolve-ShortLink -MockWith {
                $animationURL
            }
            Test-URLExtension -URL 'http://bit.ly/fakeaddress' `
                -Type Animation | Should -Be $true
        } #it

        It 'should return false if the URL cannot be reached' {
            Mock Confirm-Url -MockWith {
                $false
            } #endmock
            Test-URLExtension -URL 'http://bit.ly/fakeaddress' `
                -Type Animation | Should -Be $false
        } #it

    } #describe
} #inModule
