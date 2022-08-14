<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram extension type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported extension type
.EXAMPLE
    Test-URLExtension -URL $URL -Type Photo

    Verifies if the URL path specified is a supported photo extension type
.EXAMPLE
    Test-URLExtension -URL $PhotoURL -Type Photo -Verbose

    Verifies if the URL path specified is a supported photo extension type with Verbose output
.EXAMPLE
    Test-URLExtension -URL $VideoURL -Type Video

    Verifies if the URL path specified is a supported video extension type
.EXAMPLE
    Test-URLExtension -URL $AudioURL -Type Audio

    Verifies if the URL path specified is a supported audio extension type
.EXAMPLE
    Test-URLExtension -URL $AnimationURL -Type Animation

    Verifies if the URL path specified is a supported animation extension type
.EXAMPLE
    Test-URLExtension -URL $DocumentURL -Type Document

    Verifies if the URL path specified is a supported document extension type
.EXAMPLE
    Test-URLExtension -URL $StickerURL -Type Sticker

    Verifies if the URL path specified is a supported sticker extension type
.PARAMETER URL
    The URL string to the specified online file
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-URLExtension {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of document')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Telegram message type')]
        [ValidateSet('Photo', 'Video', 'Audio', 'Animation', 'Document', 'Sticker')]
        [string]$Type
    )
    #------------------------------------------------------------
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
    $supportedVideoExtensions = @(
        'MP4'
    )
    $supportedAudioExtensions = @(
        'MP3',
        'M4A'
    )
    $supportedAnimationExtensions = @(
        'GIF'
    )
    $supportedDocumentExtensions = @(
        'PDF',
        'GIF',
        'ZIP'
    )
    $supportedStickerExtensions = @(
        'WEBP',
        'TGS',
        'WEBM'
    )
    switch ($Type) {
        Photo {
            $extType = $supportedPhotoExtensions
        } #photo
        Video {
            $extType = $supportedVideoExtensions
        } #video
        Audio {
            $extType = $supportedAudioExtensions
        } #audio
        Animation {
            $extType = $supportedAnimationExtensions
        } #animation
        Document {
            $extType = $supportedDocumentExtensions
        } #document
        Sticker {
            $extType = $supportedStickerExtensions
        } #sticker
    } #switch_Type
    Write-Verbose -Message "Validating type: $Type"
    #------------------------------------------------------------
    [bool]$results = $true #assume the best.
    #------------------------------------------------------------
    Write-Verbose -Message 'Testing provided URL'
    $urlEval = Confirm-URL -Uri $URL
    if ($urlEval -ne $true) {
        Write-Verbose -Message 'URL Confirmation did not return true.'
        $results = $false
        return $results
    } #if_urlEval
    #------------------------------------------------------------
    Write-Verbose -Message 'Resolving potential shortlink...'
    $slEval = Resolve-ShortLink -Uri $URL -ErrorAction SilentlyContinue
    if ($slEval) {
        $URL = $slEval
    } #if_slEval
    #------------------------------------------------------------
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split('.')
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToUpper()
    Write-Verbose -Message "Verifying discovered extension: $extension"
    switch ($extension) {
        { $extType -contains $_ } {
            Write-Verbose -Message 'Extension verified.'
        }
        default {
            Write-Warning -Message "The specified file is not a supported $Type extension."
            $results = $false
        } #default
    } #switch_extension
    #------------------------------------------------------------
    return $results
} #function_Test-URLExtension
