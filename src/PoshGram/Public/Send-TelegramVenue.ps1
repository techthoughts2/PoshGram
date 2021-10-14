<#
.Synopsis
    Sends Telegram information about a venue.
.DESCRIPTION
    Uses Telegram Bot API to send latitude, longitude, title, and address information about a venue to specified Telegram chat.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $latitude = 37.621313
    $longitude = -122.378955
    $title = 'Star Fleet Headquarters'
    $address = 'San Francisco, CA 94128'
    Send-TelegramVenue -BotToken $botToken -ChatID $chat -Latitude $latitude -Longitude $longitude -Title $title -Address $address

    Sends venue information via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $latitude = 37.621313
    $longitude = -122.378955
    $title = 'Star Fleet Headquarters'
    $address = 'San Francisco, CA 94128'
    $sendTelegramVenueSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        Latitude            = $latitude
        Longitude           = $longitude
        Title               = $title
        Address             = $address
        DisableNotification = $true
        Verbose             = $true
    }
    Send-TelegramVenue @sendTelegramVenueSplat

    Sends venue information via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER Latitude
    Latitude of the venue
.PARAMETER Longitude
    Longitude of the venue
.PARAMETER Title
    Name of the venue
.PARAMETER Address
    Address of the venue
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.OUTPUTS
    System.Management.Automation.PSCustomObject (if successful)
    System.Boolean (on failure)
.NOTES
    Author: Jake Morrison - @jakemorrison - https://techthoughts.info/
    This works with PowerShell Version: 6.1+

    For a description of the Bot API, see this page: https://core.telegram.org/bots/api
    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    latitude                Float number            Yes         Latitude of the venue
    longitude               Float number            Yes         Longitude of the venue
    title                   String                  Yes         Name of the venue
    address                 String                  Yes         Address of the venue
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramVenue.md
.LINK
    https://core.telegram.org/bots/api#sendvenue
#>
function Send-TelegramVenue {
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
            HelpMessage = 'Latitude of the venue')]
        [ValidateRange(-90, 90)]
        [single]$Latitude,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Longitude of the venue')]
        [ValidateRange(-180, 180)]
        [single]$Longitude,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Name of the venue')]
        [ValidateNotNullOrEmpty()]
        [string]$Title,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Address of the venue')]
        [ValidateNotNullOrEmpty()]
        [string]$Address,
        [Parameter(Mandatory = $false,
            HelpMessage = 'Send the message silently')]
        [switch]$DisableNotification
    )
    #------------------------------------------------------------------------
    $results = $true #assume the best
    #------------------------------------------------------------------------
    $uri = "https://api.telegram.org/bot$BotToken/sendVenue"
    $Form = @{
        chat_id              = $ChatID
        latitude             = $Latitude
        longitude            = $Longitude
        title                = $Title
        address              = $Address
        disable_notification = $DisableNotification.IsPresent
    } #form
    #------------------------------------------------------------------------
    $invokeRestMethodSplat = @{
        Uri         = $Uri
        ErrorAction = 'Stop'
        Form        = $Form
        Method      = 'Post'
    }
    #------------------------------------------------------------------------
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram venue:'
        Write-Error $_
        $results = $false
    } #catch_messageSend
    return $results
    #------------------------------------------------------------------------
} #function_Send-TelegramVenue
