<#
.SYNOPSIS
    This script is used in AWS CodeBuild to install the required PowerShell Modules
    for the build process.
#>
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$VerbosePreference = 'SilentlyContinue'

# List of PowerShell Modules required for the build
# The AWS PowerShell Modules are added below, based on the $PSEdition
$modulesToInstall = [System.Collections.ArrayList]::new()
$null = $modulesToInstall.Add(([PSCustomObject]@{
    ModuleName    = 'Pester'
    ModuleVersion = '4.9.0'
    BucketName    = 'ps-invoke-modules'
    KeyPrefix     = ''
}))
$null = $modulesToInstall.Add(([PSCustomObject]@{
    ModuleName    = 'InvokeBuild'
    ModuleVersion = '5.5.6'
    BucketName    = 'ps-invoke-modules'
    KeyPrefix     = ''
}))
$null = $modulesToInstall.Add(([PSCustomObject]@{
    ModuleName    = 'PSScriptAnalyzer'
    ModuleVersion = '1.18.3'
    BucketName    = 'ps-invoke-modules'
    KeyPrefix     = ''
}))
$null = $modulesToInstall.Add(([PSCustomObject]@{
    ModuleName    = 'platyPS'
    ModuleVersion = '0.12.0'
    BucketName    = 'ps-invoke-modules'
    KeyPrefix     = ''
}))

$tempPath = [System.IO.Path]::GetTempPath()
if ($PSVersionTable.Platform -eq 'Win32NT') {
    $moduleInstallPath = [System.IO.Path]::Combine($env:ProgramFiles, 'WindowsPowerShell', 'Modules')
    if ($PSEdition -eq 'Core') {
        $moduleInstallPath = [System.IO.Path]::Combine($env:ProgramFiles, 'PowerShell', 'Modules')
        # Add the AWSPowerShell.NetCore Module
        $null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'AWSPowerShell.NetCore'
            ModuleVersion = '3.3.604.0'
            BucketName    = 'ps-invoke-modules'
            KeyPrefix     = ''
        }))
    }
    else{
        $moduleInstallPath = [System.IO.Path]::Combine($env:ProgramFiles, 'WindowsPowerShell', 'Modules')
        # Add the AWSPowerShell Module
        $null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'AWSPowerShell'
            ModuleVersion = '3.3.604.0'
            BucketName    = 'ps-invoke-modules'
            KeyPrefix     = ''
        }))
    }
}
elseif ($PSVersionTable.Platform -eq 'Unix') {
    $moduleInstallPath = [System.IO.Path]::Combine('/', 'usr', 'local', 'share', 'powershell', 'Modules')

    # Add the AWSPowerShell.NetCore Module
    $null = $modulesToInstall.Add(([PSCustomObject]@{
        ModuleName    = 'AWSPowerShell.NetCore'
        ModuleVersion = '3.3.604.0'
        BucketName    = 'ps-invoke-modules'
        KeyPrefix     = ''
    }))
}
else{
    throw 'Unrecognized OS platform'
}

'Installing PowerShell Modules'
foreach ($module in $modulesToInstall) {
    '  - {0} {1}' -f $module.ModuleName, $module.ModuleVersion

    # Download file from S3
    $key = '{0}_{1}.zip' -f $module.ModuleName, $module.ModuleVersion
    $localFile = Join-Path -Path $tempPath -ChildPath $key

    # Download modules from S3 to using the AWS CLI
    $s3Uri = 's3://{0}/{1}{2}' -f $module.BucketName, $module.KeyPrefix, $key
    & aws s3 cp $s3Uri $localFile --quiet

    # Ensure the download worked
    if (-not(Test-Path -Path $localFile)) {
        $message = 'Failed to download {0}' -f $module.ModuleName
        "  - $message"
        throw $message
    }

    # Create module path
    $modulePath = Join-Path -Path $moduleInstallPath -ChildPath $module.ModuleName
    $moduleVersionPath = Join-Path -Path $modulePath -ChildPath $module.ModuleVersion
    $null = New-Item -Path $modulePath -ItemType 'Directory' -Force
    $null = New-Item -Path $moduleVersionPath -ItemType 'Directory' -Force

    # Expand downloaded file
    Expand-Archive -Path $localFile -DestinationPath $moduleVersionPath -Force
}