function Get-iOSFeatureAvailability
{
    [CmdletBinding()]
    param
    (
        [ValidateNotNull()][string[]]$Feature = '*',
        [ValidateNotNull()][string[]]$Value = '*'
    )

    ConvertTo-HtmlDocument -Uri 'https://www.apple.com/ios/feature-availability/'
    | Select-HtmlNode -CssSelector 'section.features div.section-content' -All
    | ForEach-Object {
        $CurrentFeature = $_
        $FeatureName = $CurrentFeature | Select-HtmlNode -CssSelector h2 | Get-HtmlNodeText

        if($Feature.Where({$FeatureName -like $_}, 'First'))
        {
            $CurrentFeature
            | Select-HtmlNode -CssSelector li -All
            | ForEach-Object { $_ | Get-HtmlNodeText }
            | Where-Object { $CurrentEntry = $_; $Value.Where({$CurrentEntry -like $_}, 'First') }
            | ForEach-Object {
                [PSCustomObject]@{
                    PSTypeName = 'UncommonSense.Apple.iOSFeatureAvailability'
                    Feature = $FeatureName
                    Value = $_
                }
            }
        }
    }
}