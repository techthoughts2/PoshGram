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
    Describe 'Resolve-ShortLink' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        Context 'Error' {

            It 'should return the absolute uri if one is detected' {
                Mock Invoke-WebRequest -MockWith {
                    $errorDetails = '{"code": 21212, "message": "The ''From'' number is not a valid phone number, shortcode, or alphanumeric sender ID.", "more_info": "https://www.twilio.com/docs/errors/21212", "status": 400}'
                    # [System.Net.Http.Headers.HttpHeaders] = @{
                    #     Location = @{
                    #         AbsoluteUri = 'http://www.google.com'
                    #     }
                    # }
                    [System.Net.Http.Headers.HttpHeaders]::new() | Add-Member -MemberType NoteProperty -Name 'Location' -Value @{
                        AbsoluteUri = 'http://www.google.com'
                    }
                    $statusCode = 301
                    $response = New-Object System.Net.Http.HttpResponseMessage $statusCode
                    $response.Headers = @{
                        Location = @{
                            AbsoluteUri = 'http://www.google.com'
                        }
                    }
                    $exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
                    # https://groups.google.com/g/pester/c/ZgNpVc36Z0k?pli=1
                    #___________________
                    [System.Exception]$exception = "The remote server returned an error: (400) Bad Request."
                    [System.String]$errorId = 'BadRequest'
                    [Management.Automation.ErrorCategory]$errorCategory = [Management.Automation.ErrorCategory]::InvalidOperation
                    [System.Object]$target = 'Whatevs'
                    $errorRecord = New-Object Management.Automation.ErrorRecord ($exception, $errorID, $errorCategory, $target)
                    [System.Management.Automation.ErrorDetails]$errorDetails = '{"message":"Username does not exist: [user]"}'
                    $errorRecord.ErrorDetails = $errorDetails
                    throw $errorRecord
                } #endMock
            } #it

        } #context_error

        Context 'Success' {

            It 'should return null if no redirect detected' {
                Resolve-ShortLink -Uri 'https://www.google.com' | Should -BeNullOrEmpty
            } #it

        } #context_success
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
                } #endMock
                Resolve-ShortLink -Uri 'https://gph.is/2nlyzm4' | Should

                } #it
                $hi = [System.Net.Http.HttpResponseMessage]::new()
                $hi.Headers = [System.Net.Http.Headers.HttpResponseHeaders]::Equals()
                [System.Net.Http.HttpResponseMessage] = @(
                    Headers = [System.Net.Http.Headers.HttpResponseHeaders] = @(
                        Location = @ {
                            AbsoluteUri = 'https://giphy.com/gifs/cbs-star-trek-3o7WIxTr05mKzBTFUk'
                        }
                    )
                )

                Mock Invoke-WebRequest -MockWith {
                    [PSCustomObject]@{
                        StatusCode        = "200"
                        StatusDescription = "OK"
                        Content           = "{137, 80, 78, 71...}"
                        RawContent        = "HTTP/1.1 200 OK"
                        Headers           = "{[Content-Security-Policy, default-src 'none'; style-src 'unsafe-inline'; sandbox], [Strict-Transport-Security, max-age=31536000], [X-Content-Type-Options, nosniff]"
                        RawContentLength  = "119136"
                    }
                } #endMock
            } #it
            #>
    } #describe
} #inModule
