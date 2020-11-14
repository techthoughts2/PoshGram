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
    Describe 'Resolve-ShortLink' -Tag Unit {
        #I haven't figured out at this time how to properly mock Invoke-WebRequest errors that indicate a re-direction condition.
        #as such, there is no test coverage for this function at this time
        <#
            it 'should return the redirected URL if a Moved header is found' {

                Mock Invoke-WebRequest -MockWith {

                    [Microsoft.PowerShell.Commands.HttpResponseException]$Exception = @{

                    }
                }

                Mock Invoke-WebRequest -MockWith {
                    [System.Exception]$exception = 'Operation is not valid due to the current state of the object.'
                    [System.String]$errorId = 'WebCmdletWebResponseException$'
                    [Management.Automation.ErrorCategory]$errorCategory = [Management.Automation.ErrorCategory]::InvalidOperation
                    [System.Object]$target = 'Whatevs'
                    $errorRecord = New-Object Management.Automation.ErrorRecord ($exception, $errorID,$errorCategory, $target)
                    [System.Management.Automation.ErrorDetails]$errorDetails = '{"message":"The maximum redirection count has been exceeded. To increase the number of redirections allowed
                    , supply a higher value to the -MaximumRedirection parameter."}'
                    $errorRecord.ErrorDetails = $errorDetails
                    throw $errorRecord
                }#endMock
                Resolve-ShortLink -Uri 'https://gph.is/2nlyzm4' | Should

                }#it
                $hi = [System.Net.Http.HttpResponseMessage]::new()
                $hi.Headers = [System.Net.Http.Headers.HttpResponseHeaders]::Equals()
                [System.Net.Http.HttpResponseMessage] = @(
                    Headers = [System.Net.Http.Headers.HttpResponseHeaders] = @(
                        Location = @ {
                            AbsoluteUri = 'https://giphy.com/gifs/cbs-star-trek-3o7WIxTr05mKzBTFUk'
                        }
                    )
                )

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
            }#it
            #>
    }#describe
}#inModule