<#
.Synopsis
    Verifies that poll options are supported by Telegram
.DESCRIPTION
    Evaluates if the provided poll options meet the Telegram poll requirements.
.EXAMPLE
    Test-PollOptions -PollOptions $options

    Verifies if the provided options meet the poll requirements.
.EXAMPLE
    Test-PollOptions -PollOptions $options

    Verifies if the provided options meet the poll requirements with verbose output.
.PARAMETER PollOptions
    Poll Options for eval
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    Telegram currently supports 2-10 options 1-100 characters each
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-PollOptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Poll Options for eval')]
        [string[]]$PollOptions
    )
    $results = $true #assume the best
    Write-Verbose -Message 'Evaluating number of options...'
    $optionCount = $PollOptions.Length
    if ($optionCount -lt 2 -or $optionCount -gt 10) {
        Write-Warning -Message 'Only 2-10 poll options are allowed.'
        $results = $false
    } #if_optionCount
    else {
        Write-Verbose -Message 'Option number verified.'
        Write-Verbose -Message 'Evaluating character length of options...'
        foreach ($option in $PollOptions) {
            if ($option.Length -lt 1 -or $option.Length -gt 100) {
                Write-Warning -Message "$option is not between 1-100 characters."
                $results = $false
            } #if_length
        } #foreach_option
    } #else_optionCount
    return $results
} #function_Test-PollOptions
