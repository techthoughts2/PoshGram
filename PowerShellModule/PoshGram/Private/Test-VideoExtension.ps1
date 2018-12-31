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