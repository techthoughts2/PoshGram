<#
.Synopsis
    Verifies that MediaGroup requirements are met.
.DESCRIPTION
    Evaluates the provided files to determine if they met all MediaGroup requirements.
.EXAMPLE
    Test-MediaGroupRequirements -MediaType Photo -FilePaths $files

    Verifies if the provided files adhere to the Telegram MediaGroup requirements.
.PARAMETER MediaType
    Type of media to send
.PARAMETER FilePaths
    List of filepaths for media you want to send
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    Telegram currently supports a 50MB file size for bots
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-MediaGroupRequirements {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Type of media to send')]
        [ValidateSet('Photo', 'Video', 'Document', 'Audio')]
        [string]$MediaType,
        [Parameter(Mandatory = $false,
            HelpMessage = 'List of filepaths for media you want to send')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string[]]$FilePaths
    )

    Write-Verbose -Message 'Evaluating the group of files for MediaGroup requirements...'
    $results = $true #assume the best

    Write-Verbose -Message 'Evaluating file count...'
    if ($FilePaths.Count -le 1 -or $FilePaths.Count -gt 10) {
        Write-Warning -Message 'Send-TelegramMediaGroup requires a minimum of 2 and a maximum of 10 media files to be provided.'
        $results = $false
        return $results
    } #file_Count
    else {
        Write-Verbose -Message "File count is: $($FilePaths.Count)"
    } #else_FileCount

    foreach ($file in $FilePaths) {
        $fileTypeEval = $null
        $fileSizeEval = $null
        Write-Verbose -Message 'Verifying presence of media...'
        if (-not(Test-Path -Path $file)) {
            Write-Warning -Message "The specified media path: $file was not found."
            $results = $false
            return $results
        } #if_testPath
        if ($MediaType -ne 'Document') {
            Write-Verbose -Message 'Verifying extension type...'
            $fileTypeEval = Test-FileExtension -FilePath $file -Type $MediaType
            if ($fileTypeEval -eq $false) {
                $results = $false
                return $results
            } #if_Extension
            else {
                Write-Verbose -Message 'Extension supported.'
            } #else_Extension
        }
        Write-Verbose -Message 'Verifying file size...'
        $fileSizeEval = Test-FileSize -Path $file
        if ($fileSizeEval -eq $false) {
            $results = $false
            return $results
        } #if_Size
        else {
            Write-Verbose -Message 'File size verified.'
        } #else_Size
    } #foreach_File

    return $results

} #Test-MediaGroupRequirements
