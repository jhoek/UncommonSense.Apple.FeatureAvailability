Import-Module UncommonSense.Apple.FeatureAvailability -Force

Get-Command -Module UncommonSense.Apple.FeatureAvailability
| Sort-Object -Property Noun, Verb
| Convert-HelpToMarkDown `
    -Title 'UncommonSense.Apple.FeatureAvailability' `
    -Description 'PowerShell module for retrieving iOS and MacOS feature availability' `
    -Preface PREFACE.md
| Out-File .\README.md
