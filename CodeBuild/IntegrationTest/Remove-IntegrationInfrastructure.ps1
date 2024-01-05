<#
  This removes any required infrastructure after the Pester integration tests run.
  It is invoked whether the build succeeeds or fails, and is invoked in the
  "post_build" phase of CodeBuild.
#>

# $env:AWSAccountId = the AWS Account hosting the MOF Maker stack we're testing
# $env:CODEBUILD_RESOLVED_SOURCE_VERSION = the CodeCommit Commit Id

#$ErrorActionPreference = 'Stop'
#Import-Module -Name 'AWSPowerShell.NetCore'
