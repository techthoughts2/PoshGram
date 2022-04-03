<#
.Synopsis
    Sends Telegram phone contact message via BOT API.
.DESCRIPTION
    Uses Telegram Bot API to send contact information to specified Telegram chat.
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $phone = '1-222-222-2222'
    $firstName = 'Jean-Luc'
    Send-TelegramContact -BotToken $botToken -ChatID $chat -PhoneNumber $phone -FirstName $firstName

    Sends contact via Telegram API
.EXAMPLE
    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    $phone = '1-222-222-2222'
    $firstName = 'Jean-Luc'
    $lastName = 'Picard'
    $sendTelegramContactSplat = @{
        BotToken            = $botToken
        ChatID              = $chat
        PhoneNumber         = $phone
        FirstName           = $firstName
        LastName            = $lastName
        DisableNotification = $true
        ProtectContent      = $true
        Verbose             = $true
    }
    Send-TelegramContact @sendTelegramContactSplat

    Sends contact via Telegram API
.PARAMETER BotToken
    Use this token to access the HTTP API
.PARAMETER ChatID
    Unique identifier for the target chat
.PARAMETER PhoneNumber
    Contact phone number
.PARAMETER FirstName
    Contact first name
.PARAMETER LastName
    Contact last name
.PARAMETER DisableNotification
    Send the message silently. Users will receive a notification with no sound.
.PARAMETER ProtectContent
    Protects the contents of the sent message from forwarding and saving
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

    How do I get my channel ID? Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
    How do I set up a bot and get a token? Use the BotFather https://t.me/BotFather
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
.FUNCTIONALITY
    Parameter               Type                    Required    Description
    chat_id                 Integer or String       Yes         Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    phone_number            String                  Yes         Contact's phone number
    first_name              String                  Yes         Contact's first name
    last_name               String                  Optional    Contact's last name
.LINK
    https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramContact.md
.LINK
    https://core.telegram.org/bots/api#sendcontact
.LINK
    https://core.telegram.org/bots/api
#>
function Send-TelegramContact {
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
            HelpMessage = 'Contact phone number')]
        [ValidateNotNullOrEmpty()]
        [string]$PhoneNumber,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Contact first name')]
        [ValidateNotNullOrEmpty()]
        [string]$FirstName,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Contact last name')]
        [ValidateNotNullOrEmpty()]
        [string]$LastName,

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
        phone_number         = $PhoneNumber
        first_name           = $FirstName
        last_name            = $LastName
        disable_notification = $DisableNotification.IsPresent
        protect_content      = $ProtectContent.IsPresent
    } #form

    $uri = 'https://api.telegram.org/bot{0}/sendContact' -f $BotToken
    Write-Debug -Message ('Base URI: {0}' -f $uri)

    Write-Verbose -Message 'Sending contact...'
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
        Write-Warning -Message 'An error was encountered sending the Telegram contact:'
        if ($_.ErrorDetails) {
            $results = $_.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
        }
        else {
            throw $_
        }
    } #catch_messageSend

    return $results
} #function_Send-TelegramContact
