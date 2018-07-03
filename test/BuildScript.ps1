
Write-Host "---------------------" -ForegroundColor Gray
Write-Host 'Running Build Script' -ForegroundColor Cyan
Write-Host "---------------------" -ForegroundColor Gray
Write-Host "ModuleName    : $env:ModuleName"
Write-Host "Build version : $env:APPVEYOR_BUILD_VERSION"
Write-Host "Author        : $env:APPVEYOR_REPO_COMMIT_AUTHOR"
Write-Host "Branch        : $env:APPVEYOR_REPO_BRANCH"
Write-Host "---------------------" -ForegroundColor Gray
Write-Host 'Nothing to build, skipping.....'