# $env:SERVICE_NAME = name of the project
# $env:ARTIFACT_S3_BUCKET = the artifact bucket used by CB
# $env:AWS_ACCOUNTID = the AWS Account hosting the service under test
# $env:GIT_REPO = the git repo name
# $env:S3_PREFIX = the artifact prefix used by CB


Describe -Name 'Infrastructure Tests' -Fixture {
    BeforeAll {
        try {
            $cfnExports = Get-CFNExport -ErrorAction Stop
        }
        catch {
            throw
        }
        $script:ServiceName = $env:SERVICE_NAME
        $script:AWSRegion = $env:AWS_REGION
        $script:AWSAccountID = $env:AWS_ACCOUNTID
    } #before_all

    Context -Name 'buckets.yml' -Fixture {

        It -Name 'Should create a PoshGramTestFilesBucketARN' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-PoshGramTestFilesARN" }).Value
            $expected = 'arn:aws:s3::*'
            $assertion | Should -BeLike $expected
        } #it

        It -Name 'Should create a PoshGramURLTestFilesARN' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-PoshGramURLTestFilesARN" }).Value
            $expected = 'arn:aws:s3::*'
            $assertion | Should -BeLike $expected
        } #it

    } #context_buckets.yml

    Context -Name 'codebuild.yml' -Fixture {

        It -Name 'Should create a EnhancementCBWindowspwshArn' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-EnhancementCBWindowspwshArn" }).Value
            $expected = "arn:aws:codebuild:*"
            $assertion | Should -BeLike $expected
        } #it

        It -Name 'Should create a EnhancementsCBLinuxpwshARN' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-EnhancementsCBLinuxpwshARN" }).Value
            $expected = "arn:aws:codebuild:*"
            $assertion | Should -BeLike $expected
        } #it

        It -Name 'Should create a MainCBWindowspwshARN' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-MainCBWindowspwshARN" }).Value
            $expected = "arn:aws:codebuild:*"
            $assertion | Should -BeLike $expected
        } #it

        It -Name 'Should create a MainCBLinuxpwshARN' -Test {
            $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-MainCBLinuxpwshARN" }).Value
            $expected = "arn:aws:codebuild:*"
            $assertion | Should -BeLike $expected
        } #it

    } #context_codebuild.yml

    # Context -Name 'codepipeline.yml' -Fixture {

    #     It -Name 'Should create a PoshGramEnhancementsCICDPipelineName' -Test {
    #         $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-PoshGramEnhancementsCICDPipelineName" }).Value
    #         $expected = "$ServiceName-Enhancements-CodePipeline"
    #         $assertion | Should -BeLike $expected
    #     } #it

    #     It -Name 'Should create a PoshGrammainCICDPipelineName' -Test {
    #         $assertion = ($cfnExports | Where-Object { $_.Name -eq "$ServiceName-PoshGrammainCICDPipelineName" }).Value
    #         $expected = "$ServiceName-main-CodePipeline"
    #         $assertion | Should -BeLike $expected
    #     } #it

    # } #context_codepipeline.yml

} #describe_infra_tests
