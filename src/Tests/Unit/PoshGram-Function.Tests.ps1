#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip"
    $animationURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/jean.gif"
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
        'mp3'
    )
    $supportedAnimationExtensions = @(
        'GIF'
    )
    $supportedStickerExtensions = @(
        'WEBP',
        'TGS'
    )
    #-------------------------------------------------------------------------
    Describe 'PoshGram Supporting Function Tests' -Tag Unit {
        Context 'Test-FileExtension' {
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
        }#context_Test-FileExtension
        Context 'Test-URLExtension' {
            Mock Confirm-Url -MockWith {
                $true
            }#endmock
            Mock Resolve-ShortLink {}
            It 'should return false when a non-supported extension is provided' {
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Photo | Should -Be $false
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Video | Should -Be $false
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Audio | Should -Be $false
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Animation | Should -Be $false
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Document | Should -Be $false
                Test-URLExtension -URL "https://techthoughts.info/file.xml" `
                    -Type Sticker | Should -Be $false
            }#it
            Context 'Photo' {
                foreach ($extension in $supportedPhotoExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Photo | Should -Be $true
                    }#it
                }#foreach
            }#context_Photo
            Context 'Video' {
                foreach ($extension in $supportedVideoExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Video | Should -Be $true
                    }#it
                }#foreach
            }#context_Video
            Context 'Audio' {
                foreach ($extension in $supportedAudioExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Audio | Should -Be $true
                    }#it
                }#foreach
            }#context_Audio
            Context 'Animation' {
                foreach ($extension in $supportedAnimationExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Animation | Should -Be $true
                    }#it
                }#foreach
            }#context_Animation
            Context 'Document' {
                foreach ($extension in $supportedDocumentExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Document | Should -Be $true
                    }#it
                }#foreach
            }#context_Document
            Context 'Sticker' {
                foreach ($extension in $supportedStickerExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "https://techthoughts.info/file.$extension" `
                            -Type Sticker | Should -Be $true
                    }#it
                }#foreach
            }#context_Sticker
            It 'should properly resolve an extension after a shortlink is resolved' {
                Mock Confirm-Url -MockWith {
                    $true
                }#endmock
                Mock Resolve-ShortLink -MockWith {
                    $animationURL
                }
                Test-URLExtension -URL "http://bit.ly/fakeaddress" `
                    -Type Animation | Should -Be $true
            }#it
            It 'should return false if the URL cannot be reached' {
                Mock Confirm-Url -MockWith {
                    $false
                }#endmock
                Test-URLExtension -URL "http://bit.ly/fakeaddress" `
                    -Type Animation | Should -Be $false
            }
        }#context_Test-URLExtension
        Context 'Test-FileSize' {
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
        }#context_Test-FileSize
        Context 'Test-URLFileSize' {
            It 'Should return true when the file is at or below 50MB' {
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
                Test-URLFileSize -URL $fileURL | Should -Be $true
            }#it
            It 'should return false when the file is over 50MB' {
                mock Invoke-WebRequest -MockWith {
                    [PSCustomObject]@{
                        StatusCode        = "200"
                        StatusDescription = "OK"
                        Content           = "{137, 80, 78, 71...}"
                        RawContent        = "HTTP/1.1 200 OK"
                        Headers           = "{[Content-Security-Policy, default-src 'none'; style-src 'unsafe-inline'; sandbox], [Strict-Transport-Security, max-age=31536000], [X-Content-Type-Options, nosniff]"
                        RawContentLength  = "1593681272"
                    }
                }#endMock
                Test-URLFileSize -URL $fileURL | Should -Be $false
            }#it
            It 'should return false when an error is encountered' {
                mock Invoke-WebRequest -MockWith {
                    Throw 'Bullshit Error'
                }#endMock
                Test-URLFileSize -URL $fileURL | Should -Be $false
            }
        }#context_Test-URLFileSize
        Context 'Confirm-URL' {
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
        }#Confirm-URL
        Context 'Test-PollOptions' {
            It 'should return false if the number of options is below 2' {
                $opt = @(
                    'One'
                )
                Test-PollOptions -PollOptions $opt | Should -Be $false
            }#it
            It 'should return false if the number of options is above 10' {
                $opt = @(
                    'One',
                    'Two',
                    'Three',
                    'Four',
                    'Five',
                    'Six',
                    'Seven',
                    'Eight',
                    'Nine',
                    'Ten',
                    'Eleven'
                )
                Test-PollOptions -PollOptions $opt | Should -Be $false
            }#it
            It 'should return false if an option has a character count above 100' {
                $opt = @(
                    'Three',
                    'Four',
                    'uhvfulonqhitqljlpyiziijocidwiljbjyezzkzmvcahymsppqpqrhxpcdqbaikjbkevsohjnjtdrmrvwoconbqeaemouzzpypeeg'
                )
                Test-PollOptions -PollOptions $opt | Should -Be $false
            }#it
            It 'should return true if a valid set of options is provided' {
                $opt = @(
                    'Star Trek: The Original Series',
                    'Star Trek: The Animated Series',
                    'Star Trek: The Next Generation',
                    'Star Trek: Deep Space Nine',
                    'Star Trek: Voyager',
                    'Star Trek: Enterprise',
                    'Star Trek: Discovery',
                    'Star Trek: Picard'
                )
                Test-PollOptions -PollOptions $opt | Should -Be $true
            }#it
        }#Test-PollOptions
        Context 'Resolve-ShortLink' {
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
        }#context_Resolve-ShortLink
    }#describe_SupportingFunctions
}#inModule