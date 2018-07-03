#region supporting Functions

<#
.Synopsis
    Verifies that specified file is a supported Telegram photo type
.DESCRIPTION
    Evaluates the specified file path to determine if the file is a supported photo type
.EXAMPLE
    Test-PhotoExtension -ImagePath C:\photos\aphoto.jpg

    Verifies if the path specified is a supported photo extension type
.EXAMPLE
    Test-PhotoExtension -ImagePath $ImagePath -Verbose

    Verifies if the path specified in $ImagePath is a supported photo extension type with verbose output
.PARAMETER ImagePath
    File path to the photo location
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-PhotoExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'File path to photo')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ImagePath
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $ImagePath ..."
    $divide = $ImagePath.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "jpg" -or $extension -eq "jpeg" -or $extension -eq "png" -or $extension -eq "gif" -or $extension -eq "bmp" -or $extension -eq "webp" -or $extension -eq "svg" -or $extension -eq "tiff") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified file is not a supported photo extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-PhotoExtension
<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram document type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported document type
.EXAMPLE
    Test-URLExtension -URL $URL

    Verifies if the URL path specified is a supported document extension type
.EXAMPLE
    Test-URLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported document extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    https://core.telegram.org/bots/api#senddocument
    GIF, PDF, ZIP
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-URLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of document')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "gif" -or $extension -eq "pdf" -or $extension -eq "zip") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported document extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-URLExtension
<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram photo type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported photo type
.EXAMPLE
    Test-PhotoURLExtension -URL $URL

    Verifies if the URL path specified is a supported photo extension type
.EXAMPLE
    Test-PhotoURLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported photo extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-PhotoURLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of document')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "jpg" -or $extension -eq "jpeg" -or $extension -eq "png" -or $extension -eq "gif" -or $extension -eq "bmp" -or $extension -eq "webp" -or $extension -eq "svg" -or $extension -eq "tiff") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported photo extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-PhotoURLExtension
<#
.Synopsis
    Verifies that specified file is a supported Telegram video type
.DESCRIPTION
    Evaluates the specified file path to determine if the file is a specified video type
.EXAMPLE
    Test-VideoExtension -ImagePath C:\videos\video.mp4

    Verifies if the path specified is a supported video extension type
.EXAMPLE
    Test-VideoExtension -ImagePath $ImagePath -Verbose

    Verifies if the path specified in $VideoPath is a supported video extension type with verbose output
.PARAMETER VideoPath
    File path to the video location
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    MP4
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-VideoExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'File path to video')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$VideoPath
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $VideoPath ..."
    $divide = $VideoPath.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "mp4") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified file is not a supported video extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-VideoExtension
<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram video type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported video type
.EXAMPLE
    Test-VideoURLExtension -URL $URL

    Verifies if the URL path specified is a supported video extension type
.EXAMPLE
    Test-VideoURLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported video extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    MP4
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-VideoURLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of video')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "mp4") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported video extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-VideoURLExtension
<#
.Synopsis
    Verifies that specified file is a supported Telegram audio type
.DESCRIPTION
    Evaluates the specified file path to determine if the file is a specified photo type
.EXAMPLE
    Test-AudioExtension -AudioPath C:\audio\audio.mp3

    Verifies if the path specified is a supported photo extension type
.EXAMPLE
    Test-AudioExtension -AudioPath $AudioPath -Verbose

    Verifies if the path specified in $ImagePath is a supported photo extension type with verbose output
.PARAMETER AudioPath
    File path to the audio location
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    MP3
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-AudioExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'File path to audio')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$AudioPath
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $AudioPath ..."
    $divide = $AudioPath.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "mp3") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified file is not a supported photo extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-AudioExtension
<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram audio type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported audio type
.EXAMPLE
    Test-AudioURLExtension -URL $URL

    Verifies if the URL path specified is a supported audio extension type
.EXAMPLE
    Test-AudioURLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported audio extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    MP3
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-AudioURLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of audio')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "mp3") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported video extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-AudioURLExtension
<#
.Synopsis
    Verifies that file size is supported by Telegram
.DESCRIPTION
    Evaluates if the file is at or below the supported Telegram file size
.EXAMPLE
    Test-FileSize -Path C:\videos\video.mp4

    Verifies if the path specified is a supported video extension type
.EXAMPLE
    Test-FileSize -Path $Path -Verbose

    Verifies if the path specified in $VideoPath is a supported video extension type with verbose output
.PARAMETER Path
    Path to file
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Telegram currently supports a 50MB file size for bots
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-FileSize {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Path to file')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )
    $results = $true #assume the best
    $supportedSize = 50
    try {
        $size = Get-ChildItem -Path $Path -ErrorAction Stop
        if (($size.Length / 1MB) -gt $supportedSize) {
            Write-Warning -Message "The file is over $supportedSize (MB)"
            $results = $false
        }
    }
    catch {
        Write-Warning -Message "An error was encountered evaluating the file size"
        $results = $false
    }
    return $results
}#function_Test-FileSize
<#
.Synopsis
    Verifies that specified URL file size is supported by Telegram
.DESCRIPTION
    Evaluates the specified URL path to determine if the file is at or below the supported Telegram file size
.EXAMPLE
    Test-URLFileSize -URL "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"

    Verifies if the file in the specified URL is at or below the Telegram maximum size
.EXAMPLE
    Test-URLFileSize -URL $URL -Verbose

    Verifies if the file in the specified URL is at or below the Telegram maximum size with verbose output
.PARAMETER URL
    URL address to file
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Telegram currently supports a 50MB file size for bots
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-URLFileSize {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL address to file')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    $results = $true #assume the best
    $supportedSize = 50
    try {
        $urlFileInfo = Invoke-WebRequest $URL -ErrorAction Stop
        if (($urlFileInfo.RawContentLength / 1MB) -gt $supportedSize) {
            Write-Warning -Message "The file is over $supportedSize (MB)"
            $results = $false
        }
    }
    catch {
        Write-Warning -Message "An error was encountered evaluating the file size"
        $results = $false
    }
    return $results
}#function_Test-URLFileSize

#endregion
#region Telegram Test Functions

<#
.Synopsis
    Validates Bot auth Token
.DESCRIPTION
    A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    Test-BotToken -BotToken $botToken

    Validates the specified Bot auth token via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    Test-BotToken `
        -BotToken $botToken `
        -Verbose

    Validates the specified Bot auth token via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1
    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Test-BotToken.md
.LINK
    https://core.telegram.org/bots/api#getme
#>
function Test-BotToken {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Testing Bot Token..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/getMe" -f $BotToken) `
            -Method Get `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered testing the BOT token:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Test-BotToken

#endregion
#region Telegram Send Functions

<#
.Synopsis
    Sends Telegram text message via Bot API
.DESCRIPTION
    Uses Telegram Bot API to send text message to specified Telegram chat. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Hello"

    Sends text message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    Send-TelegramTextMessage `
        -BotToken $botToken `
        -ChatID $chat `
        -Message "Hello *chat* _channel_, check out this link: [TechThoughts](http://techthoughts.info/)" `
        -ParseMode Markdown `
        -Preview $false `
        -DisableNotification $false `
        -Verbose

    Sends text message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Message
    Text of the message to be sent
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER Preview
    Disables link previews for links in this message. Default is $false
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1
    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 					Type 				Required 	Description
    chat_id 				    Integer or String 	Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    text 						String 				Yes 		Text of the message to be sent
    parse_mode 					String 				Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    disable_web_page_preview 	Boolean 			Optional 	Disables link previews for links in this message
    disable_notification 		Boolean 			Optional 	Sends the message silently. Users will receive a notification with no sound.
    reply_to_message_id 	    Integer 			Optional 	If the message is a reply, ID of the original message
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramTextMessage.md
.LINK
    https://core.telegram.org/bots/api#sendmessage
#>
function Send-TelegramTextMessage {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'Text of the message to be sent')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Message,
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Disables link previews')]
        [bool]$Preview = $false, #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $payload = @{
        "chat_id"                  = $ChatID
        "text"                     = $Message
        "parse_mode"               = $ParseMode
        "disable_web_page_preview" = $Preview
        "disable_notification"     = $DisableNotification
    }#payload
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/sendMessage" -f $BotToken) `
            -Method Post `
            -ContentType "application/json" `
            -Body (ConvertTo-Json -Compress -InputObject $payload) `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramTextMessage

<#
.Synopsis
    Sends Telegram photo message via Bot API from locally sourced photo image
.DESCRIPTION
    Uses Telegram Bot API to send photo message to specified Telegram chat. The photo will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photo = "C:\photos\aphoto.jpg"
    Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chat -PhotoPath $photo

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photo = "C:\photos\aphoto.jpg"
    Send-TelegramLocalPhoto `
        -BotToken $botToken `
        -ChatID $chat `
        -PhotoPath $photo `
        -Caption "Check out this photo" `
        -ParseMode Markdown `
        -DisableNotification $false `
        -Verbose

    Sends photo message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER PhotoPath
    File path to local image
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Contributor: Mark Kraus - @markekraus - thanks for the form tip!
    This works with PowerShell Version: 6.1

    The following photo types are supported:
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    photo 					InputFile or String 	Yes 		Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files »
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md
.LINK
    https://core.telegram.org/bots/api#sendphoto
#>
function Send-TelegramLocalPhoto {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'File path to the photo you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PhotoPath,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Photo caption')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying presence of photo..."
    if (!(Test-Path -Path $PhotoPath)) {
        Write-Warning "The specified photo path: $PhotoPath was not found."
        $results = $false
        return $results
    }#if_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying extension type..."
    $fileTypeEval = Test-PhotoExtension -ImagePath $PhotoPath
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_photoExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_photoExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying file size..."
    $fileSizeEval = Test-FileSize -Path $PhotoPath
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_photoSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_photoSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $PhotoPath -ErrorAction Stop
    }#try_Get-ItemPhoto
    catch {
        Write-Warning "The specified photo could not be interpreted properly."
        $results = $false
        return $results
    }#catch_Get-ItemPhoto
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendphoto"
    $Form = @{
        chat_id              = $ChatID
        photo                = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification
    }#form
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram photo message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocalPhoto

<#
.Synopsis
    Sends Telegram photo message via Bot API from URL sourced photo image
.DESCRIPTION
    Uses Telegram Bot API to send photo message to specified Telegram chat. The photo will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
    Send-TelegramURLPhoto -BotToken $botToken -ChatID $chat -PhotoURL $photourl

    Sends photo message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photoURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png"
    Send-TelegramURLPhoto `
        -BotToken $botToken `
        -ChatID $chat `
        -PhotoURL $photourl `
        -Caption "DSC is a great technology" `
        -ParseMode Markdown `
        -DisableNotification $false `
        -Verbose

    Sends photo message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER PhotoURL
    URL path to photo
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    https://core.telegram.org/bots/api#sendphoto
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    photo 					InputFile or String 	Yes 		Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files »
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md
.LINK
    https://core.telegram.org/bots/api#sendphoto
#>
function Send-TelegramURLPhoto {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL path to photo')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PhotoURL,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Photo caption')]
        [string]$Caption,
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL leads to supported photo extension..."
    $fileTypeEval = Test-PhotoURLExtension -URL $PhotoURL
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_documentExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL presence and file size..."
    $fileSizeEval = Test-URLFileSize -URL $PhotoURL
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_photoSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_photoSize
    #------------------------------------------------------------------------
    $payload = @{
        "chat_id"              = $ChatID
        "photo"                = $PhotoURL
        "caption"              = $Caption
        "parse_mode"           = $ParseMode
        "disable_notification" = $DisableNotification
    }#payload
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/sendphoto" -f $BotToken) `
            -Method Post `
            -ContentType "application/json" `
            -Body (ConvertTo-Json -Compress -InputObject $payload) `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramURLPhoto

<#
.Synopsis
    Sends Telegram document message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send document message to specified Telegram chat. The document will be sourced from the local device and uploaded to Telegram. Several options can be specified to adjust message parameters.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $file = "C:\Logs\Log1.txt"
    Send-TelegramLocalDocument -BotToken $botToken -ChatID $chat -File $file

    Sends document message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $file = "C:\Logs\Log1.txt"
    Send-TelegramLocalDocument `
        -BotToken $botToken `
        -ChatID $chat `
        -File $file `
        -Caption "Check out this file" `
        -ParseMode Markdown `
        -DisableNotification $false `
        -Verbose

    Sends document message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER File
    Local path to file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Contributor: Mark Kraus - @markekraus - thanks for the form tip!
    This works with PowerShell Version: 6.1

    Bots can currently send files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    document 				InputFile or String 	Yes 		File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalDocument.md
.LINK
    https://core.telegram.org/bots/api#senddocument
#>
function Send-TelegramLocalDocument {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$File,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying presence of file..."
    if (!(Test-Path -Path $File)) {
        Write-Warning "The specified file: $File was not found."
        $results = $false
        return $results
    }#if_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying file size..."
    $fileSizeEval = Test-FileSize -Path $File
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_photoSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_photoSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $File -ErrorAction Stop
    }#try_Get-ItemPhoto
    catch {
        Write-Warning "The specified file could not be interpreted properly."
        $results = $false
        return $results
    }#catch_Get-ItemPhoto
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendDocument"
    $Form = @{
        chat_id              = $ChatID
        document             = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        disable_notification = $DisableNotification
    }#form
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram document message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocalDocument

<#
.Synopsis
    Sends Telegram document message via Bot API from URL sourced file
.DESCRIPTION
    Uses Telegram Bot API to send document message to specified Telegram chat. The file will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters. Only works for gif, pdf and zip files.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip"
    Send-TelegramURLDocument -BotToken $botToken -ChatID $chat -FileURL $fileURL

    Sends document message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $fileURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/LogExample.zip"
    Send-TelegramURLDocument `
        -BotToken $botToken `
        -ChatID $chat `
        -FileURL $fileURL `
        -Caption "Log Files" `
        -ParseMode Markdown `
        -DisableNotification $false `
        -Verbose

    Sends document message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER FileURL
    URL path to file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1

    In sendDocument, sending by URL will currently only work for gif, pdf and zip files.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    document 				InputFile or String 	Yes 		File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLDocument.md
.LINK
    https://core.telegram.org/bots/api#senddocument
#>
function Send-TelegramURLDocument {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL path to file')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$FileURL,
        [Parameter(Mandatory = $false,
            HelpMessage = 'File caption')]
        [string]$Caption,
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL leads to supported document extension..."
    $fileTypeEval = Test-URLExtension -URL $FileURL
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_documentExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL presence and file size..."
    $fileSizeEval = Test-URLFileSize -URL $FileURL
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_documentSize
    #------------------------------------------------------------------------
    $payload = @{
        "chat_id"              = $ChatID
        "document"             = $FileURL
        "caption"              = $Caption
        "parse_mode"           = $ParseMode
        "disable_notification" = $DisableNotification
    }#payload
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/sendDocument" -f $BotToken) `
            -Method Post `
            -ContentType "application/json" `
            -Body (ConvertTo-Json -Compress -InputObject $payload) `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramURLDocument

<#
.Synopsis
    Sends Telegram video message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send video message to specified Telegram chat. The video will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters. Telegram only supports mp4 videos.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $file = "C:\videos\video.mp4"
    Send-TelegramLocalVideo -BotToken $botToken -ChatID $chat -Video $video

    Sends video message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $video = "C:\videos\video.mp4"
    Send-TelegramLocalVideo `
        -BotToken $botToken `
        -ChatID $chat `
        -Video $video `
        -Duration 10 `
        -Width 250 `
        -Height 250 `
        -Caption "Check out this video" `
        -ParseMode Markdown `
        -Streaming $true `
        -DisableNotification $false `
        -Verbose

    Sends video message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Video
    Local path to video file
.PARAMETER Duration
    Duration of sent video in seconds
.PARAMETER Width
    Video width
.PARAMETER Height
    Video height
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER Streaming
    Pass True, if the uploaded video is suitable for streaming
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Contributor: Mark Kraus - @markekraus - thanks for the form tip!
    This works with PowerShell Version: 6.1

    Telegram clients support mp4 videos (other formats may be sent as Document)
    Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    video    				InputFile or String 	Yes 		Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data.
    duration                Integer                 Optional    Duration of sent video in seconds
    width                   Integer                 Optional    Video width
    height                  Integer                 Optional    Video height
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    supports_streaming      Boolean                 Optional    Pass True, if the uploaded video is suitable for streaming
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalVideo.md
.LINK
    https://core.telegram.org/bots/api#sendvideo
#>
function Send-TelegramLocalVideo {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Video,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of video in seconds')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Duration,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Video width')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Width,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Video height')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Height,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Pass True, if the uploaded video is suitable for streaming')]
        [bool]$Streaming, #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying presence of file..."
    if (!(Test-Path -Path $Video)) {
        Write-Warning "The specified file: $Video was not found."
        $results = $false
        return $results
    }#if_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying extension type..."
    $fileTypeEval = Test-VideoExtension -VideoPath $Video
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_videoExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_videoExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying file size..."
    $fileSizeEval = Test-FileSize -Path $Video
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_videoSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_videoSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $Video -ErrorAction Stop
    }#try_Get-ItemVideo
    catch {
        Write-Warning "The specified file could not be interpreted properly."
        $results = $false
        return $results
    }#catch_Get-ItemVideo
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendVideo"
    $Form = @{
        chat_id              = $ChatID
        video                = $fileObject
        duration             = $Duration
        width                = $Width
        height               = $Height
        caption              = $Caption
        parse_mode           = $ParseMode
        supports_streaming   = $Streaming
        disable_notification = $DisableNotification
    }#form
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram video message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocalVideo

<#
.Synopsis
    Sends Telegram video message via Bot API from URL sourced file
.DESCRIPTION
    Uses Telegram Bot API to send video message to specified Telegram chat. The file will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters. Only works for gif, pdf and zip files.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $videourl = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Intro.mp4"
    Send-TelegramURLVideo -BotToken $botToken -ChatID $chat -VideoURL $videourl

    Sends video message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $videourl = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Intro.mp4"
    Send-TelegramURLVideo `
        -BotToken $botToken `
        -ChatID $chat `
        -VideoURL $videourl `
        -Duration 16 `
        -Width 1920 `
        -Height 1080 `
        -Caption "Check out this video" `
        -ParseMode Markdown `
        -Streaming $false `
        -DisableNotification $false `
        -Verbose

    Sends video message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER VideoURL
    URL path to video file
.PARAMETER Duration
    Duration of sent video in seconds
.PARAMETER Width
    Video width
.PARAMETER Height
    Video height
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER Streaming
    Pass True, if the uploaded video is suitable for streaming
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1

    Telegram clients support mp4 videos (other formats may be sent as Document)
    Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    video    				InputFile or String 	Yes 		Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data.
    duration                Integer                 Optional    Duration of sent video in seconds
    width                   Integer                 Optional    Video width
    height                  Integer                 Optional    Video height
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    supports_streaming      Boolean                 Optional    Pass True, if the uploaded video is suitable for streaming
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLVideo.md
.LINK
    https://core.telegram.org/bots/api#sendvideo
#>
function Send-TelegramURLVideo {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$VideoURL,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of video in seconds')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Duration,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Video width')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Width,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Video height')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Int32]$Height,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Pass True, if the uploaded video is suitable for streaming')]
        [bool]$Streaming, #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL leads to supported document extension..."
    $fileTypeEval = Test-VideoURLExtension -URL $VideoURL
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_documentExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL presence and file size..."
    $fileSizeEval = Test-URLFileSize -URL $VideoURL
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_documentSize
    #------------------------------------------------------------------------
    $payload = @{
        chat_id              = $ChatID
        video                = $VideoURL
        duration             = $Duration
        width                = $Width
        height               = $Height
        caption              = $Caption
        parse_mode           = $ParseMode
        supports_streaming   = $Streaming
        disable_notification = $DisableNotification
    }#payload
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/sendVideo" -f $BotToken) `
            -Method Post `
            -ContentType "application/json" `
            -Body (ConvertTo-Json -Compress -InputObject $payload) `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramURLVideo

<#
.Synopsis
    Sends Telegram audio message via Bot API from locally sourced file
.DESCRIPTION
    Uses Telegram Bot API to send audio message to specified Telegram chat. The audio will be sourced from the local device and uploaded to telegram. Several options can be specified to adjust message parameters. Telegram only supports mp3 audio.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $audio = "C:\audio\halo_on_fire.mp3"
    Send-TelegramLocalAudio -BotToken $botToken -ChatID $chat -Audio $audio

    Sends audio message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $audio = "C:\audio\halo_on_fire.mp3"
    Send-TelegramLocalAudio `
        -BotToken $botToken `
        -ChatID $chat `
        -Audio $audio `
        -Caption "Check out this audio track" `
        -ParseMode Markdown `
        -Duration 495 `
        -Performer "Metallica" `
        -Title "Halo On Fire" `
        -DisableNotification $false `
        -Verbose

    Sends audio message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Audio
    Local path to audio file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER Performer
    Performer
.PARAMETER Title
    Track Name
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    Contributor: Mark Kraus - @markekraus - thanks for the form tip!
    This works with PowerShell Version: 6.1

    Your audio must be in the .mp3 format.
    Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    audio    				InputFile or String 	Yes 		Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data.
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    duration                Integer                 Optional    Duration of the audio in seconds
    performer               String                  Optional    Performer
    title                   String                  Optional    Track Name
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalAudio.md
.LINK
    https://core.telegram.org/bots/api#sendaudio
#>
function Send-TelegramLocalAudio {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Audio,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of the audio in seconds')]
        [int]$Duration,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Performer')]
        [string]$Performer,
        [Parameter(Mandatory = $false,
            HelpMessage = 'TrackName')]
        [string]$Title,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying presence of file..."
    if (!(Test-Path -Path $Audio)) {
        Write-Warning "The specified file: $Audio was not found."
        $results = $false
        return $results
    }#if_testPath
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying extension type..."
    $fileTypeEval = Test-AudioExtension -AudioPath $Audio
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_videoExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_videoExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying file size..."
    $fileSizeEval = Test-FileSize -Path $Audio
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_videoSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_videoSize
    #------------------------------------------------------------------------
    try {
        $fileObject = Get-Item $Audio -ErrorAction Stop
    }#try_Get-ItemVideo
    catch {
        Write-Warning "The specified file could not be interpreted properly."
        $results = $false
        return $results
    }#catch_Get-ItemVideo
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendAudio"
    $Form = @{
        chat_id              = $ChatID
        audio                = $fileObject
        caption              = $Caption
        parse_mode           = $ParseMode
        duration             = $Duration
        performer            = $Performer
        title                = $Title
        disable_notification = $DisableNotification
    }#form
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram audio message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocalAudio

<#
.Synopsis
    Sends Telegram audio message via Bot API from URL sourced file
.DESCRIPTION
    Uses Telegram Bot API to send audio message to specified Telegram chat. The file will be sourced from the provided URL and sent to Telegram. Several options can be specified to adjust message parameters. Only works for mp3 files.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $audioURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
    Send-TelegramURLAudio -BotToken $botToken -ChatID $chat -AudioURL $audioURL

    Sends audio message via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $audioURL = "https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/Tobu-_-Syndec-Dusk-_NCS-Release_-YouTube.mp3"
    Send-TelegramURLAudio `
        -BotToken $botToken `
        -ChatID $chat `
        -AudioURL $audioURL `
        -Caption "Check out this audio track" `
        -ParseMode Markdown `
        -Duration 495 `
        -Performer "Metallica" `
        -Title "Halo On Fire" `
        -DisableNotification $false `
        -Verbose

    Sends audio message via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER AudioURL
    URL path to audio file
.PARAMETER Caption
    Brief title or explanation for media
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER ParseMode
    Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message. Default is Markdown.
.PARAMETER Duration
    Duration of the audio in seconds
.PARAMETER Performer
    Performer
.PARAMETER Title
    Track Name
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Versions: 5.1, 6.0, 6.1

    Your audio must be in the .mp3 format.
    Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
   PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters 				Type    				Required 	Description
    chat_id 				Integer or String 		Yes 		Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    audio    				InputFile or String 	Yes 		Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data.
    caption 				String 					Optional 	Photo caption (may also be used when resending photos by file_id), 0-200 characters
    parse_mode 				String 					Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    duration                Integer                 Optional    Duration of the audio in seconds
    performer               String                  Optional    Performer
    title                   String                  Optional    Track Name
    disable_notification 	Boolean 				Optional 	Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLAudio.md
.LINK
    https://core.telegram.org/bots/api#sendaudio
#>
function Send-TelegramURLAudio {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = '#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$BotToken, #you could set a token right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = '-#########')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ChatID, #you could set a Chat ID right here if you wanted
        [Parameter(Mandatory = $true,
            HelpMessage = 'Local path to file you wish to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$AudioURL,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Caption for file')]
        [string]$Caption = "", #set to false by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'HTML vs Markdown for message formatting')]
        [ValidateSet("Markdown", "HTML")]
        [string]$ParseMode = "Markdown", #set to Markdown by default
        [Parameter(Mandatory = $false,
            HelpMessage = 'Duration of the audio in seconds')]
        [int]$Duration,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Performer')]
        [string]$Performer,
        [Parameter(Mandatory = $false,
            HelpMessage = 'TrackName')]
        [string]$Title,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL leads to supported audio extension..."
    $fileTypeEval = Test-AudioURLExtension -URL $AudioURL
    if ($fileTypeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentExtension
    else {
        Write-Verbose -Message "Extension supported."
    }#else_documentExtension
    #------------------------------------------------------------------------
    Write-Verbose -Message "Verifying URL presence and file size..."
    $fileSizeEval = Test-URLFileSize -URL $AudioURL
    if ($fileSizeEval -eq $false) {
        $results = $false
        return $results
    }#if_documentSize
    else {
        Write-Verbose -Message "File size verified."
    }#else_documentSize
    #------------------------------------------------------------------------
    $payload = @{
        chat_id              = $ChatID
        audio                = $AudioURL
        caption              = $Caption
        parse_mode           = $ParseMode
        duration             = $Duration
        performer            = $Performer
        title                = $Title
        disable_notification = $DisableNotification
    }#payload
    #------------------------------------------------------------------------
    try {
        Write-Verbose -Message "Sending message..."
        $results = Invoke-RestMethod `
            -Uri ("https://api.telegram.org/bot{0}/sendAudio" -f $BotToken) `
            -Method Post `
            -ContentType "application/json" `
            -Body (ConvertTo-Json -Compress -InputObject $payload) `
            -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram message:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramURLAudio

#endregion