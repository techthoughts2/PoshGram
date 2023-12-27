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
        ProtectContent      = $true
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
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    Questions on how to set up a bot, get a token, or get your channel ID?
    Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/
.COMPONENT
    PoshGram
.FUNCTIONALITY
    Parameters              Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    latitude                Float number            Yes         Latitude of the venue
    longitude               Float number            Yes         Longitude of the venue
    title                   String                  Yes         Name of the venue
    address                 String                  Yes         Address of the venue
    disable_notification    Boolean                 Optional    Sends the message silently. Users will receive a notification with no sound.
.LINK
    https://poshgram.readthedocs.io/en/latest/Send-TelegramVenue
.LINK
    https://core.telegram.org/bots/api#sendvenue
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramVenue {
    [CmdletBinding()]
    param (
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
        [switch]$DisableNotification,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Protects the contents of the sent message from forwarding and saving')]
        [switch]$ProtectContent
    )

    Write-Verbose -Message ('Starting: {0}' -f $MyInvocation.Mycommand)

    $form = @{
        chat_id              = $ChatID
        latitude             = $Latitude
        longitude            = $Longitude
        title                = $Title
        address              = $Address
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendVenue' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending venue...'
    $invokeRestMethodSplat = @{
        Uri         = $uri
        ErrorAction = 'Stop'
        Form        = $form
        Method      = 'Post'
    }
    try {
        $results = Invoke-RestMethod @invokeRestMethodSplat
    } #try_messageSend
    catch {
        Write-Warning -Message 'An error was encountered sending the Telegram venue:'
        Write-Error $_
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramVenue
