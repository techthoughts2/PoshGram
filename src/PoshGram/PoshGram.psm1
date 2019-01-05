#this psm1 is for locally testing and development use only
# Sets the Script Path variable to the scripts invocation path.
$paths = @('Private','Public')

# dot source the parent import
#. $PSScriptRoot\Imports.ps1

foreach ($path in $paths) {
    # Retrieve all .ps1 files in the Functions subfolder
    $files = Get-ChildItem "$PSScriptRoot\$path" -Filter '*.ps1' -File

    # Dot source all .ps1 file found
    foreach ($file in $files) {
        try {
            . $file.FullName
        }
        catch {
            if ($_.Exception.Message -notlike '*cannot be run because it contains a "#requires" statement for running as Administrator.*') {
                throw
            }
        }
    }
}