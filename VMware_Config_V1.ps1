



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

###### Create VM Template #######

New-VM -Name 'WIN2016VM' `
    -ResourcePool Cluster1 `
    -NumCPU 2 `
    -MemoryGB 8 `
    -DiskStorageFormat thin `
    -DiskGB 40 `
    -NetworkName "LAB Network"

$template = Get-VM | Where-Object {$_.Name -eq "Windows_Server_2012R2_Template"} | Set-VM -ToTemplate -Name Windows_Server_2012R2_Template
 
$fileName = 'F:\ESXi550-201602001.zip'
$tgtFolder = 'Test'
 
$ds = Get-VMHost -Name "hqidvpztvh02.hqh.intra.aexp.com" | Get-Datastore "T2-Test-LUN01"
 
New-PSDrive -Location $ds -Name DS -PSProvider VimDatastore -Root "\" > $null
 
if(!(Test-Path -Path "DS:/$($tgtFolder)")){
    New-Item -ItemType Directory -Path "DS:/$($tgtFolder)" > $null
}
Copy-DatastoreItem -Item $fileName -Destination "DS:/$($tgtFolder)"
 
Remove-PSDrive -Name DS -Confirm:$false