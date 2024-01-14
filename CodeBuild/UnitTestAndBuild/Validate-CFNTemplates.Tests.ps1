$paths = @(
    'cloudformation'
)
$files = Get-ChildItem -Path $paths -Recurse -Filter '*.yml'
$ErrorActionPreference = 'Stop'

Describe 'CloudFormation Template Validation' {

    Context -Name 'CloudFormation Templates' {
        Context -Name '<_.Name>' -Foreach $files {
            It 'is valid CFN' {
                { Test-CFNTemplate -TemplateBody (Get-Content -Path $_.FullName -Raw) } | Should -Not -Throw
            } #it
        }
    } #context_cfn_templates

} #describe_cfn_templates
