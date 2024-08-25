function Get-MacOSFeatureAvailability
{
    param
    (
        [Parameter()][ValidateNotNull()][string[]]$Feature = '*',
        [Parameter()][ValidateNotNull()][string[]]$Value = '*'
    )

    ConvertTo-HtmlDocument -Uri 'https://www.apple.com/macos/feature-availability/'
    | Select-HtmlNode -CssSelector 'section.features div.section-content' -All
    | ForEach-Object {
        $CurrentFeature = $_
        $FeatureName = $CurrentFeature | Select-HtmlNode -CssSelector h4 | Get-HtmlNodeText

        if($Feature.Where({$FeatureName -like $_}, 'First'))
        {
            $CurrentFeature
            | Select-HtmlNode -CssSelector li -All
            | ForEach-Object { $_ | Get-HtmlNodeText }
            | Where-Object { $CurrentEntry = $_; $Value.Where({$CurrentEntry -like $_}, 'First') }
            | ForEach-Object {
                [PSCustomObject]@{
                    PSTypeName = 'UncommonSense.Apple.MacOSFeatureAvailability'
                    Feature = $FeatureName
                    Value = $_
                }
            }
        }
    }
}