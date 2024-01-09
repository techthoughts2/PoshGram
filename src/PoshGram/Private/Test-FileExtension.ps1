<#
.SYNOPSIS
    Verifies that specified file is a supported Telegram extension type
.DESCRIPTION
    Evaluates the specified file path to determine if the file is a supported extension type
.EXAMPLE
    Test-FileExtension -FilePath C:\photos\aphoto.jpg -Type Photo

    Verifies if the path specified is a supported photo extension type
.EXAMPLE
    Test-FileExtension -FilePath $PhotoPath -Type Photo -Verbose

    Verifies if the path specified in $PhotoPath is a supported photo extension type with verbose output
.EXAMPLE
    $fileTypeEval = Test-FileExtension -FilePath $AnimationPath -Type Animation

    Verifies if the path specified is a supported Animation extension type
.EXAMPLE
    $fileTypeEval = Test-FileExtension -FilePath $Audio -Type Audio

    Verifies if the path specified is a supported Audio extension type
.EXAMPLE
    $fileTypeEval = Test-FileExtension -FilePath $PhotoPath -Type Photo

    Verifies if the path specified is a supported photo extension type
.EXAMPLE
    $fileTypeEval = Test-FileExtension -FilePath $Video -Type Video

    Verifies if the path specified is a supported Video extension type
.EXAMPLE
    $fileTypeEval = Test-FileExtension -FilePath $Sticker -Type Sticker

    Verifies if the path specified is a supported Sticker extension type
.PARAMETER FilePath
    Path to file that will be evaluated
.PARAMETER Type
    Telegram message type
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
.COMPONENT
    PoshGram
#>
function Test-FileExtension {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Path to file that will be evaluated')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$FilePath,
        [Parameter(Mandatory = $true,
            HelpMessage = 'Telegram message type')]
        [ValidateSet('Photo', 'Video', 'Audio', 'Animation', 'Sticker')]
        [string]$Type
    )
    #------------------------------------------------------------
    $supportedPhotoExtensions = @(
        'JPG'
        'JPEG'
        'PNG'
        'GIF'
        'BMP'
        'WEBP'
        'SVG'
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
    $supportedStickerExtensions = @(
        'WEBP'
        'TGS'
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
        Sticker {
            $extType = $supportedStickerExtensions
        }
    } #switch_Type
    Write-Verbose -Message "Validating type: $Type"
    #------------------------------------------------------------
    [bool]$results = $true #assume the best.
    #------------------------------------------------------------
    Write-Verbose -Message "Processing $FilePath ..."
    $divide = $FilePath.Split('.')
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
    return $results
} #function_Test-FileExtension
