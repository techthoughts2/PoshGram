#-------------------------------------------------------------------------
#if the module is already in memory, remove it
$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

#$runLocal = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleManifestName = 'PoshGram.psd1'
$moduleManifestPath = "$script:moduleRoot\$moduleManifestName"
#$moduleManifestPath = "$runLocal\$moduleManifestName"
$moduleName = 'PoshGram.psm1'
$moduleNamePath = "$script:moduleRoot\$moduleName"

#-------------------------------------------------------------------------
$aFunctions = @(
    'Test-PhotoExtension',
    'Test-URLExtension',
    'Test-PhotoURLExtension',
    'Test-VideoExtension',
    'Test-VideoURLExtension',
    'Test-AudioExtension',
    'Test-AudioURLExtension',
    'Test-FileSize',
    'Test-URLFileSize',
    'Test-BotToken',
    'Send-TelegramTextMessage',
    'Send-TelegramLocalPhoto',
    'Send-TelegramURLPhoto',
    'Send-TelegramLocalDocument',
    'Send-TelegramLocalVideo',
    'Send-TelegramURLVideo',
    'Send-TelegramLocalAudio',
    'Send-TelegramURLAudio'
)
$mFunctions = @(
    'Test-BotToken',
    'Send-TelegramTextMessage',
    'Send-TelegramLocalPhoto',
    'Send-TelegramURLPhoto',
    'Send-TelegramLocalDocument',
    'Send-TelegramLocalVideo',
    'Send-TelegramURLVideo',
    'Send-TelegramLocalAudio',
    'Send-TelegramURLAudio'
)
$hFunctions = @(
    'Test-PhotoExtension',
    'Test-URLExtension',
    'Test-PhotoURLExtension',
    'Test-VideoExtension',
    'Test-VideoURLExtension',
    'Test-AudioExtension',
    'Test-AudioURLExtension',
    'Test-FileSize',
    'Test-URLFileSize'
)
#-------------------------------------------------------------------------
Describe 'Module Tests' -Tag Unit {
    Context "Module Tests" {
        It 'Passes Test-ModuleManifest' {
            Test-ModuleManifest -Path $ModuleManifestPath | Should Not BeNullOrEmpty
            $? | Should Be $true
        }#manifestTest
        It 'root module PoshGram.psm1 should exist' {
            $moduleNamePath | Should Exist
            $? | Should Be $true
        }#psm1Exists
        It 'manifest should contain PoshGram.psm1' {
            $moduleManifestPath |
                Should -FileContentMatchExactly "PoshGram.psm1"
        }#validPSM1
    }#context_ModuleTests
    Context "Function Tests" {
        Context "Manifest Functions" {
            foreach ($function in $mFunctions) {
                It "$function should exist in PoshGram.psd1" {
                    $moduleManifestPath |
                        Should -FileContentMatchExactly $function
                }#mFunctions
            }#foreach
            foreach ($function in $hFunctions) {
                It "$function should not exist in PoshGram.psd1" {
                    $moduleManifestPath |
                        Should -Not -FileContentMatchExactly $function
                }#hFunctions
            }#foreach
        }#context_ManifestFunctions
        Context "Module Functions" {
            foreach ($function in $aFunctions) {
                It "$function should exist in PoshGram.psm1" {
                    $moduleNamePath |
                        Should -FileContentMatchExactly $function
                }#aFunctions
            }#foreach
        }#context_ModuleFunctions
    }#context_FunctionTests
}#describe_ModuleTests