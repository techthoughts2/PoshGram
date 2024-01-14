$paths = @(
    'cloudformation'
)
$files = Get-ChildItem -Path $paths -File -Recurse -Filter '*.json'
$ErrorActionPreference = 'Stop'

Describe -Name 'JSON Configuration File Validation' {

    Context -Name 'JSON Parameter Files' {
        Context -Name '<_.Name>' -Foreach $files {
            It 'is valid JSON' {
                { $null = ConvertFrom-Json -InputObject (Get-Content -Path $_.FullName -Raw) } | Should -Not -Throw
            } #it
        }
    } #context_json_parameter_files

} #describe_json_configuration_file_validation
