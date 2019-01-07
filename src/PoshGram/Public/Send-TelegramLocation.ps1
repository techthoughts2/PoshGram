<#
.Synopsis
    Sends Telegram location to indicate point on map
.DESCRIPTION
    Uses Telegram Bot API to send latitude and longitude points on map to specified Telegram chat.
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $latitude = 37.621313
    $longitude = -122.378955
    Send-TelegramLocation -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude

    Sends location via Telegram API
.EXAMPLE
    $botToken = "#########:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    $chat = "-#########"
    $photo = "C:\photos\aphoto.jpg"
    Send-TelegramLocation `
        -BotToken $botToken `
        -ChatID $chat `
        -Latitude $latitude `
        -Longitude $longitude
        -DisableNotification $false `
        -Verbose

    Sends location via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Latitude
    Latitude of the location
.PARAMETER Longitude
    Longitude of the location
.PARAMETER DisableNotification
    Sends the message silently. Users will receive a notification with no sound. Default is $false
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    This works with PowerShell Version: 6.1

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    latitude                Float number            Yes         Latitude of the location
    longitude               Float number            Yes         Longitude of the location
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocation.md
.LINK
    https://core.telegram.org/bots/api#sendlocation
#>
function Send-TelegramLocation {
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
            HelpMessage = 'Latitude of the location')]
        [ValidateRange(-90, 90)]
        [single]$Latitude,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Longitude of the location')]
        [ValidateRange(-180, 180)]
        [single]$Longitude,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Sends the message silently')]
        [bool]$DisableNotification = $false #set to false by default
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendLocation"
    $Form = @{
        chat_id              = $ChatID
        latitude             = $Latitude
        longitude            = $Longitude
        disable_notification = $DisableNotification
    }#form
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form -ErrorAction Stop
    }#try_messageSend
    catch {
        Write-Warning "An error was encountered sending the Telegram location:"
        Write-Error $_
        $results = $false
    }#catch_messageSend
    return $results
    #------------------------------------------------------------------------
}#function_Send-TelegramLocation