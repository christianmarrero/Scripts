



$snapin = Get-PSSnapin -Name vmware* -ErrorAction SilentlyContinue

if (!$snapin)

    {
        Add-PSSnapin vmware*
    }

if ($snapin)

    {
        Write-Host "VMWare Snap in were inported Already"
    }

######## Variables #######
$vlan_ID = Read-Host "Enter Secomdary VLAN ID Here"
$vcenter = Read-Host "Enter vCenter Server Name or IP Address Here"
Connect-VIServer $vcenter -WarningAction SilentlyContinue

######### DO Work ############

$clustername = Get-Cluster | Where-Object {$_.Name -eq "Cluster1"} 
    $clustername | Set-Cluster -DrsEnabled:$true -Confirm:$false -HAAdmissionControlEnabled:$false
$vswitch = Get-VirtualSwitch | Where-Object {$_.Name -eq "vSwitch0"} 
        $vswitch | New-VirtualPortGroup -Name "LAB Network" -VlanId $vlan_ID
        