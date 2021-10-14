<#
.Synopsis
    Verifies that provided quiz explanation matches Telegram requirements.
.DESCRIPTION
    Evaluates if the provided quiz explanation meets the Telegram explanation requirements.
.EXAMPLE
    Test-Explanation -Explanation $explanation

    Verifies if the provided options meet the poll requirements.
.PARAMETER Explanation
    Quiz explanation text
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    Telegram currently supports 0-200 characters with at most 2 line feeds after entities parsing
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-Explanation {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Quiz explanation text')]
        [string]$Explanation
    )
    $results = $true #assume the best
    Write-Verbose -Message 'Evaluating provided explanation...'

    $splitTest = $Explanation -split '\n'
    $carriageCount = $splitTest | Measure-Object | Select-Object -ExpandProperty Count

    if ($carriageCount -gt 2) {
        Write-Warning -Message 'Explanation can contain at most 2 line feeds.'
        $results = $false
    }

    if ($Explanation.Length -gt 200) {
        Write-Warning -Message 'Explanation can contain at most 200 characters.'
        $results = $false
    }

    return $results
} #function_Test-Explanation
