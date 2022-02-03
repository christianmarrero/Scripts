

$ClusterName = Read-Host "Enter Cluster Name or IP Address"
$username = Read-Host "Enter user name"
$password = Read-Host "Enter Password"

Get-PSSnapin -Name NutanixCmdletsPSSnapin -ErrorAction SilentlyContinue | ForEach-Object {$_.Name}
if ($null -eq $myvarLoaded){Add-PSSnapin NutanixCmdletsPSSnapin}


Connect-NutanixCluster -server $ClusterName -username $username -password $password -AcceptInvalidSSLCerts


