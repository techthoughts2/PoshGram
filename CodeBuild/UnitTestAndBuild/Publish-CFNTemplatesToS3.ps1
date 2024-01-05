$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

if ([String]::IsNullOrWhiteSpace($env:ARTIFACT_S3_BUCKET)) {
    throw 'The environment variable ARTIFACT_S3_BUCKET must be configured.'
}

if ([String]::IsNullOrWhiteSpace($env:S3_KEY_PREFIX)) {
    throw 'The environment variable S3_KEY_PREFIX must be configured.'
}

# # Paths are based from the root of the GIT repository
# $paths = @(
#     './cloudformation'
# )

# if ($env:REGIONAL_BUCKET) {
#     $artifactBucket = $env:REGIONAL_BUCKET
# }
# else {
#     $artifactBucket = $env:ARTIFACT_S3_BUCKET
# }

# foreach ($path in $paths) {
#     Write-Host "Processing CloudFormation Templates in '$path':"
#     # All CloudFormation Templates to publish are located in or below the "./CloudFormation" folder
#     foreach ($file in (Get-ChildItem -Path $path -Recurse -File -Filter "*.yml")) {

#         '' # Blank line to separate CodeBuild Output

#         # Calculate the S3 Key Prefix, keeping the correct Folder Structure
#         if ($file.Name -like '*-ControlPlane.yml') {
#             $s3KeyPrefix = '{0}/CloudFormation/{1}' -f $env:S3_KEY_PREFIX, $file.Directory.Name
#         }
#         elseif ($file.Directory.Name -eq 'ChildTemplates') {
#             # Find the parent template path
#             $parentPath = Split-Path -Path $file.Directory
#             $templatePath = Split-Path -Path $parentPath -Leaf
#             $s3KeyPrefix = '{0}/CloudFormation/{1}/{2}' -f $env:S3_KEY_PREFIX, $templatePath, $file.Directory.Name
#         }
#         elseif ($file.Directory.Name -eq 'Manual') {
#             Write-Host 'Manually deployed CFN detected. Skipping.'
#             continue
#         }
#         else {
#             throw 'Unexpected directory encountered inside CloudFormation folder'
#         }

#         $s3Key = '{0}/{1}' -f $s3KeyPrefix, $file.Name
#         [string]$endPoint = "https://s3.$env:AWSRegion" + ".amazonaws.com"

#         Write-Host "ENDPOINT: $endPoint"
#         Write-Host "BUCKET: $artifactBucket"
#         Write-Host "KEY: $s3Key"
#         $writeS3ObjectSplat = @{
#             BucketName  = $artifactBucket
#             Key         = $s3Key
#             File        = $file.FullName
#             Region      = $env:AWSRegion
#             EndpointUrl = $endPoint
#         }
#         Write-S3Object @writeS3ObjectSplat

#         Remove-Variable -Name @('s3Key', 's3KeyPrefix') -ErrorAction SilentlyContinue
#     }
# }
# Update the ControlPlane Parameters JSON files with the target Artifact S3 Bucket.
# All JSON files will be updated, however the deployment CodePipeline is hard coded
# to a specific JSON file so other deployments will not be affected.
foreach ($controlPlaneFolder in (Get-ChildItem -Path './cloudformation' -Recurse -Filter '*control_plane_parameters' -Directory)) {
    foreach ($file in (Get-ChildItem -Path $controlPlaneFolder.FullName -Filter '*.json' -Recurse)) {
        $fileContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

        $fileContent.Parameters.ArtifactS3Bucket = $env:ARTIFACT_S3_BUCKET

        $fileContent.Parameters.ArtifactS3KeyPrefix = $env:S3_KEY_PREFIX

        $fileContent | ConvertTo-Json -Compress -Depth 6 | Out-File -FilePath $file.FullName -Force
    }
}