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
    Describe 'Confirm-URL' -Tag Unit {
        It 'should return false if the website can not be reached' {
            Mock Invoke-WebRequest -MockWith {
                [System.Exception]$exception = 'No such host is known'
                [System.String]$errorId = 'InvalidOperation$'
                [Management.Automation.ErrorCategory]$errorCategory = [Management.Automation.ErrorCategory]::InvalidOperation
                [System.Object]$target = 'Whatevs'
                $errorRecord = New-Object Management.Automation.ErrorRecord ($exception, $errorID, $errorCategory, $target)
                [System.Management.Automation.ErrorDetails]$errorDetails = '{"message":"No such host is known"}'
                $errorRecord.ErrorDetails = $errorDetails
                throw $errorRecord
            }#endMock
            Confirm-URL -Uri 'https://bssite.is/2nlyzm4' | Should -Be $false
        }#it
        It 'should return true when a website can be reached' {
            mock Invoke-WebRequest -MockWith {
                [PSCustomObject]@{
                    StatusCode        = "200"
                    StatusDescription = "OK"
                    Content           = "{137, 80, 78, 71...}"
                    RawContent        = "HTTP/1.1 200 OK"
                    Headers           = "{[Content-Security-Policy, default-src 'none'; style-src 'unsafe-inline'; sandbox], [Strict-Transport-Security, max-age=31536000], [X-Content-Type-Options, nosniff]"
                    RawContentLength  = "119136"
                }
            }#endMock
            Confirm-URL -Uri 'https://gph.is/2nlyzm4' |  Should -Be $true
        }#it
    }#describe
}#inModule