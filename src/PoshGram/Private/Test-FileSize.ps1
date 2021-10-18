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
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    Telegram currently supports a 50MB file size for bots
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-FileSize {
    [CmdletBinding()]
    param (
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
        Write-Warning -Message 'An error was encountered evaluating the file size'
        $results = $false
    }
    return $results
} #function_Test-FileSize
