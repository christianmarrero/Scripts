
#################### GEF Windows Server 2016 Post Install Configuration #############
#                                                                                   #
#    Created By: Benjamin Bocinski, Christian Marrero                               #                                    
#                                                                                   #
#                                                                                   #
#####################################################################################


################### Variables ##################
$Hostname = Read-Host "Enter Hyper V Host Name"
$DNSServer = "10.0.23.11"
$Domain = "esf.army.geflab"
$DomainAccount = Read-Host "Enter ESF credentials Ex esf\joe.doe.a1"
$DomainGroup = "ESF\Tier1Operators"
$VINetIP = Read-Host "Enter VI Netwrok IP Address"
$VINetGW = Read-Host "Enter VI Network Default Gateway IP Address"

Set-ExecutionPolicy Unrestricted -Force

############# Set Computer Name ################
Rename-Computer -NewName $hostname

###################### Rename Network Adapter ##############################
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet"} | Rename-NetAdapter -NewName iSCSI_A
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 2"} | Rename-NetAdapter -NewName iSCSI_B
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 3"} | Rename-NetAdapter -NewName LM
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 4"} | Rename-NetAdapter -NewName OOB_MGMT
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 5"} | Rename-NetAdapter -NewName VI
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 6"} | Rename-NetAdapter -NewName VM_AD
Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 7"} | Rename-NetAdapter -NewName VM_NETWORK 

###################### Configure VI Network #################################
$VI = Get-NetAdapter | Where-Object {$_.Name -eq "VI"}
    $VI | New-NetIPAddress $VINetIP -DefaultGateway $VINetGW -PrefixLength 24
Get-DnsClientServerAddress | Where-Object {$_.Name -eq "VI"} | Set-DnsClientServerAddress -ServerAddresses $DNSServer

###################### Set DNS server on VM_AD NIC ###########################
Get-DnsClientServerAddress | Where-Object {$_.Name -eq "VM_AD"} | Set-DnsClientServerAddress -ServerAddresses $DNSServer

##################### Enable MPIO for iSCSI #########################
Enable-WindowsOptionalFeature -Online -FeatureName MultiPathIO -ErrorAction Continue -NoRestart
##################### Install Hyper V and Failover Clustering ######################
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart:$false
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools -Restart:$false

###################### Join Server to Domain ##############################
Add-Computer -DomainName $Domain -Credential $DomainAccount -Restart -Force

# .END