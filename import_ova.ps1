$datastore = Get-Datastore -Name "vmContainer1"
$vmHost = Get-VMHost -Location "Datacenter1"
$vmHost | Import-vApp -Source '\\nutanixdc.local\dfs\images\WIn19SQL19-PW.ova' -Datastore $datastore -Force
