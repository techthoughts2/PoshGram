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