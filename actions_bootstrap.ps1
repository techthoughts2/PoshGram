# Bootstrap dependencies

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# https://docs.microsoft.com/powershell/module/packagemanagement/get-packageprovider
# Get-PackageProvider -Name Nuget -ForceBootstrap | Out-Null

# Install-Module -Name PowerShellGet -RequiredVersion 2.2.4.1 -Force -Scope CurrentUser

# https://docs.microsoft.com/powershell/module/powershellget/set-psrepository
# Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# List of PowerShell Modules required for the build
$modulesToInstall = [System.Collections.ArrayList]::new()
# https://github.com/pester/Pester
$null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'Pester'
            ModuleVersion = '5.5.0'
        }))
# https://github.com/nightroman/Invoke-Build
$null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'InvokeBuild'
            ModuleVersion = '5.10.4'
        }))
# https://github.com/PowerShell/PSScriptAnalyzer
$null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'PSScriptAnalyzer'
            ModuleVersion = '1.21.0'
        }))
# https://github.com/PowerShell/platyPS
# older version used due to: https://github.com/PowerShell/platyPS/issues/457
$null = $modulesToInstall.Add(([PSCustomObject]@{
            ModuleName    = 'platyPS'
            ModuleVersion = '0.12.0'
        }))

'Setting PSGallery to trusted'
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

'Installing PowerShell Modules'
foreach ($module in $modulesToInstall) {
    $installSplat = @{
        Name            = $module.ModuleName
        RequiredVersion = $module.ModuleVersion
        Repository      = 'PSGallery'
        Force           = $true
        ErrorAction     = 'Stop'
    }
    try {
        Install-Module @installSplat
        Import-Module -Name $module.ModuleName -ErrorAction Stop
        '  - Successfully installed {0}' -f $module.ModuleName
    }
    catch {
        $message = 'Failed to install {0}' -f $module.ModuleName
        "  - $message"
        throw $message
    }
}
