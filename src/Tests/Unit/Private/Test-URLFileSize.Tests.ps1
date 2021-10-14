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
    Describe 'Test-URLFileSize' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        BeforeEach {
            $fileURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip'
        } #before_each

        It 'Should return true when the file is at or below 50MB' {
            Mock Invoke-WebRequest -MockWith {
                [PSCustomObject]@{
                    StatusCode        = '200'
                    StatusDescription = 'OK'
                    Content           = '{137, 80, 78, 71...}'
                    RawContent        = 'HTTP/1.1 200 OK'
                    Headers           = "{[Content-Security-Policy, default-src 'none'; style-src 'unsafe-inline'; sandbox], [Strict-Transport-Security, max-age=31536000], [X-Content-Type-Options, nosniff]"
                    RawContentLength  = '119136'
                }
            } #endMock
            Test-URLFileSize -URL $fileURL | Should -Be $true
        } #it

        It 'should return false when the file is over 50MB' {
            Mock Invoke-WebRequest -MockWith {
                [PSCustomObject]@{
                    StatusCode        = '200'
                    StatusDescription = 'OK'
                    Content           = '{137, 80, 78, 71...}'
                    RawContent        = 'HTTP/1.1 200 OK'
                    Headers           = "{[Content-Security-Policy, default-src 'none'; style-src 'unsafe-inline'; sandbox], [Strict-Transport-Security, max-age=31536000], [X-Content-Type-Options, nosniff]"
                    RawContentLength  = '1593681272'
                }
            } #endMock
            Test-URLFileSize -URL $fileURL | Should -Be $false
        } #it

        It 'should return false when an error is encountered' {
            Mock Invoke-WebRequest -MockWith {
                Throw 'Bullshit Error'
            } #endMock
            Test-URLFileSize -URL $fileURL | Should -Be $false
        } #it

    } #describe
} #inModule