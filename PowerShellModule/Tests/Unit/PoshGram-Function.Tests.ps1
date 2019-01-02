
#if the module is already in memory, remove it
Get-Module PoshGram | Remove-Module -Force
#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot

$ModuleName = 'PoshGram'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")

if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------
#$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
#$moduleName = 'PoshGram.psd1'
#$moduleNamePath = "$script:moduleRoot\$moduleName"
#-------------------------------------------------------------------------
$WarningPreference = "SilentlyContinue"
#-------------------------------------------------------------------------
#Import-Module $moduleNamePath -Force

InModuleScope PoshGram {
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    $token = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip"
    $videoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Intro.mp4"
    $audioURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
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
        }#context_Test-FileExtension
        Context 'Test-URLExtension' {
            Mock Confirm-Url -MockWith {
                $true
            }#endmock
            Mock Resolve-ShortLink {}
            It 'should return false when a non-supported extension is provided' {
                Test-URLExtension -URL "http://techthoughts.info/file.xml" `
                    -Type Photo | Should -Be $false
                Test-URLExtension -URL "http://techthoughts.info/file.xml" `
                    -Type Video | Should -Be $false
                Test-URLExtension -URL "http://techthoughts.info/file.xml" `
                    -Type Audio | Should -Be $false
                Test-URLExtension -URL "http://techthoughts.info/file.xml" `
                    -Type Animation | Should -Be $false
            }#it
            Context 'Photo' {
                foreach ($extension in $supportedPhotoExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "http://techthoughts.info/file.$extension" `
                            -Type Photo | Should -Be $true
                    }#it
                }#foreach
            }#context_Photo
            Context 'Video' {
                foreach ($extension in $supportedVideoExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "http://techthoughts.info/file.$extension" `
                            -Type Video | Should -Be $true
                    }#it
                }#foreach
            }#context_Video
            Context 'Audio' {
                foreach ($extension in $supportedAudioExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "http://techthoughts.info/file.$extension" `
                            -Type Audio | Should -Be $true
                    }#it
                }#foreach
            }#context_Audio
            Context 'Animation' {
                foreach ($extension in $supportedAnimationExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "http://techthoughts.info/file.$extension" `
                            -Type Animation | Should -Be $true
                    }#it
                }#foreach
            }#context_Animation
            Context 'Document' {
                foreach ($extension in $supportedDocumentExtensions) {
                    It "should return true when $extension extension is provided" {
                        Test-URLExtension -URL "http://techthoughts.info/file.$extension" `
                            -Type Document | Should -Be $true
                    }#it
                }#foreach
            }#context_Animation
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
                    $errorRecord = New-Object Management.Automation.ErrorRecord ($exception, $errorID,$errorCategory, $target)
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
    Describe 'PoshGram Test Function Tests' -Tag Unit {
        Context 'Test-BotToken' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Test-BotToken `
                    -BotToken $token `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            id         = 2222
                            is_bot     = "True"
                            first_name = "botname"
                            username   = "botname_bot"
                        }
                    }
                }#endMock
                Test-BotToken `
                    -BotToken $token `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Test-BotToken
    }#describe_testFunctions
    Describe 'PoshGram Send Function Tests' -Tag Unit {
        Context 'Send-TelegramTextMessage' {
            It 'should return false if an error is encountered' {
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramTextMessage `
                    -BotToken $token `
                    -ChatID $chat `
                    -Message "Hi there Pester" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id = 2222
                            from       = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat       = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date       = "1530157540"
                            text       = "Diag-V is cool."
                        }
                    }
                }#endMock
                Send-TelegramTextMessage `
                    -BotToken $token `
                    -ChatID $chat `
                    -Message "Hi There Pester" `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramTextMessage
        Context 'Send-TelegramLocalPhoto' {
            It 'should return false if the photo can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" | Should -Be $false
            }#it
            It 'should return false if the photo extension is not supported' {
                mock Test-Path { $true }
                mock Test-FileExtension { $false }
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" | Should -Be $false
            }#it
            It 'should return false if the photo is too large' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $false }
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            photo            = "{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}"
                            caption          = "Please work, please"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocalPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoPath "c:\bs\diagvresults.jpg" `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramLocalPhoto
        Context 'Send-TelegramURLPhoto' {
            It 'should return false if the photo extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoURL $photoURL `
                    -Caption "DSC is a great technology" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $false }
                Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoURL $photoURL `
                    -Caption "DSC is a great technology" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoURL $photoURL `
                    -Caption "DSC is a great technology" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            photo            = "{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}"
                            caption          = "Please work, please"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramURLPhoto `
                    -BotToken $token `
                    -ChatID $chat `
                    -PhotoURL $photoURL `
                    -Caption "DSC is a great technology" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramURLPhoto
        Context 'Send-TelegramLocalDocument' {
            It 'should return false if the document can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File "C:\customlog.txt" | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-Path { $true }
                mock Test-FileSize { $false }
                Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File "C:\customlog.txt" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Test-Path { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File "C:\customlog.txt" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Test-Path { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "customlog.txt"
                    }
                }#endMock
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File "C:\customlog.txt" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-Path { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "customlog.txt"
                    }
                }#endMock
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            photo            = "{@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCjAABG9Ju7DQr02GYgMBAAEC; file_size=1084;file_path=photos/file_427.jpg; width=90; height=85},@{file_id=AgADAQAD-qcxG3V1oUWan8rsJbPxtH6vCj################; file_size=2305; width=123;height=116}}"
                            caption          = "Please work, please"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocalDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -File "C:\customlog.txt" | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramLocalDocument
        Context 'Send-TelegramURLDocument' {
            It 'should return false if the document extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -FileURL $fileURL `
                    -Caption "TechThoughts Logo" | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $false }
                Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -FileURL $fileURL `
                    -Caption "TechThoughts Logo" | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -FileURL $fileURL `
                    -Caption "TechThoughts Logo" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            document         = "@{file_name=LogExample.zip; mime_type=application/zip;file_id=BQADBAADBgAD2j69UXHVUcgmhQqsAg; file_size=216}"
                            caption          = "TechThoughts Logo"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramURLDocument `
                    -BotToken $token `
                    -ChatID $chat `
                    -FileURL $fileURL `
                    -Caption "TechThoughts Logo" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramURLDocument
        Context 'Send-TelegramLocalVideo' {
            It 'should return false if the video can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if the video extension is not supported' {
                mock Test-Path { $true }
                mock Test-FileExtension { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if the video is too large' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $false }
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            video            = "@{duration=17; width=1920; height=1080; mime_type=video/mp4; thumb=; file_id=BAADAQADPwADiOTBRROL3QmsMu9OAg;file_size=968478}"
                            caption          = "Local Video Test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocalVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -Video "C:\bs\video.mp4" `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramLocalVideo
        Context 'Send-TelegramURLVideo' {
            It 'should return false if the video extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -VideoURL $videourl `
                    -Duration 16 `
                    -Width 1920 `
                    -Height 1080 `
                    -ParseMode Markdown `
                    -Streaming $false `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $false }
                Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -VideoURL $videourl `
                    -Duration 16 `
                    -Width 1920 `
                    -Height 1080 `
                    -ParseMode Markdown `
                    -Streaming $false `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -VideoURL $videourl `
                    -Duration 16 `
                    -Width 1920 `
                    -Height 1080 `
                    -ParseMode Markdown `
                    -Streaming $false `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            video            = "@{duration=17; width=1920; height=1080; mime_type=video/mp4; thumb=; file_id=BAADAQADPwADiOTBRROL3QmsMu9OAg;file_size=968478}"
                            caption          = "Video URL test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramURLVideo `
                    -BotToken $token `
                    -ChatID $chat `
                    -VideoURL $videourl `
                    -Duration 16 `
                    -Width 1920 `
                    -Height 1080 `
                    -ParseMode Markdown `
                    -Streaming $false `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramURLVideo
        Context 'Send-TelegramLocalAudio' {
            It 'should return false if the audio can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" | Should -Be $false
            }#it
            It 'should return false if the audio extension is not supported' {
                mock Test-Path { $true }
                mock Test-FileExtension { $false }
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" | Should -Be $false
            }#it
            It 'should return false if the audio is too large' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $false }
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                            caption          = "Local Video Test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocalAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -Audio "C:\bs\audio.mp3" `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramLocalAudio
        Context 'Send-TelegramURLAudio' {
            It 'should return false if the audio extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -AudioURL $audioURL `
                    -Caption "Check out this audio track" `
                    -ParseMode Markdown `
                    -Duration 495 `
                    -Performer "Metallica" `
                    -Title "Halo On Fire" `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $false }
                Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -AudioURL $audioURL `
                    -Caption "Check out this audio track" `
                    -ParseMode Markdown `
                    -Duration 495 `
                    -Performer "Metallica" `
                    -Title "Halo On Fire" `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -AudioURL $audioURL `
                    -Caption "Check out this audio track" `
                    -ParseMode Markdown `
                    -Duration 495 `
                    -Performer "Metallica" `
                    -Title "Halo On Fire" `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                            caption          = "Video URL test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramURLAudio `
                    -BotToken $token `
                    -ChatID $chat `
                    -AudioURL $audioURL `
                    -Caption "Check out this audio track" `
                    -ParseMode Markdown `
                    -Duration 495 `
                    -Performer "Metallica" `
                    -Title "Halo On Fire" `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramURLAudio
        Context 'Send-TelegramLocalAnimation' {
            It 'should return false if the animation can not be found' {
                mock Test-Path { $false }
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" | Should -Be $false
            }#it
            It 'should return false if the animation extension is not supported' {
                mock Test-Path { $true }
                mock Test-FileExtension { $false }
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" | Should -Be $false
            }#it
            It 'should return false if the animation is too large' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $false }
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" | Should -Be $false
            }#it
            It 'should return false if it cannot successfuly get the file' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" | Should -Be $false
            }#it
            It 'should return false if an error is encountered sending the message' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-Path { $true }
                mock Test-FileExtension { $true }
                mock Test-FileSize { $true }
                mock Get-Item {
                    [PSCustomObject]@{
                        Mode          = "True"
                        LastWriteTime = "06/17/16     00:19"
                        Length        = "1902"
                        Name          = "diagvresults.jpg"
                    }
                }#endMock
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                            caption          = "Local Video Test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocalAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Animation "C:\bs\animation.gif" `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramLocalAnimation
        Context 'Send-TelegramURLAnimation' {
            It 'should return false if the animation extension is not supported' {
                mock Test-URLExtension { $false }
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if the file is too large' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $false }
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return false if an error is encountered' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                Mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Test-URLExtension { $true }
                mock Test-URLFileSize { $true }
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                            caption          = "Video URL test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramURLAnimation `
                    -BotToken $token `
                    -ChatID $chat `
                    -AnimationURL $animationURL `
                    -Caption "Check out this animation" `
                    -ParseMode Markdown `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_Send-TelegramURLAnimation
        Context 'Send-TelegramLocation' {
            It 'should return false if an error is encountered sending the location' {
                mock Invoke-RestMethod {
                    Throw 'Bullshit Error'
                }#endMock
                Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Latitude 37.621313 `
                    -Longitude -122.378955 `
                    -DisableNotification $false `
                    -ErrorAction SilentlyContinue | Should -Be $false
            }#it
            It 'should return a custom PSCustomObject if successful' {
                mock Invoke-RestMethod -MockWith {
                    [PSCustomObject]@{
                        ok     = "True"
                        result = @{
                            message_id       = 2222
                            from             = "@{id=#########; is_bot=True; first_name=botname; username=bot_name}"
                            chat             = "@{id=-#########; title=ChatName; type=group; all_members_are_administrators=True}"
                            date             = "1530157540"
                            audio            = "@{duration=225; mime_type=audio/mpeg; file_id=CQADAQADTgADiOTBRejNi8mgvPkEAg; file_size=6800709}"
                            caption          = "Video URL test"
                            caption_entities = "{@{offset=13; length=6; type=bold}}"
                        }
                    }
                }#endMock
                Send-TelegramLocation `
                    -BotToken $token `
                    -ChatID $chat `
                    -Latitude 37.621313 `
                    -Longitude -122.378955 `
                    -DisableNotification $false `
                    | Should -BeOfType System.Management.Automation.PSCustomObject
            }#it
        }#context_#Send-TelegramLocation
    }#describe_Functions
}#inModule