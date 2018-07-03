Write-Host "PowerShell Version:" $PSVersionTable.PSVersion.tostring()

if ((Get-Module -ListAvailable pester) -eq $null) {
    Install-Module -Name Pester -Repository PSGallery -Force
}

$CodeFiles = (Get-ChildItem $ENV:BHModulePath -Recurse -Include "*.psm1").FullName

Import-Module Pester
Invoke-Pester -Tag Unit -CodeCoverage $CodeFiles -PassThru