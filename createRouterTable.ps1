$path = "..\EE2.csv"
$routeTableName = 'ees02ae-dmzpriin01-udr'
$location = 'australiaeast'
$resourceGroupName = 'ees02aep-rg003'
$route = New-AzRouteTable `
  -Name $routeTableName `
  -ResourceGroupName $resourceGroupName `
  -location $location
Import-CSV -Path $path | ForEach-Object{
    $Name = $_.Name 
    $AddressPrefix = $_.AddressPrefix
    $NextHopType = $_.NextHopType 
    $NextHopIpAddress = $_.NextHopIpAddress
    Get-AzRouteTable `
      -ResourceGroupName $resourceGroupName `
      -Name $routeTableName `
    | Add-AzRouteConfig `
      -Name $Name `
      -AddressPrefix $AddressPrefix `
      -NextHopType $NextHopType `
      -NextHopIpAddress $NextHopIpAddress `
    | Set-AzRouteTable
}
