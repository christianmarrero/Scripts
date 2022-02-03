$clustername = Get-Cluster | Where-Object {$_.Name -eq "Cluster1"}

foreach ($item in $clustername){

    Write-Host "Looking for Cluster Named Cluster 1..." -ForegroundColor Yellow
    
        if ($clustername)

            {
                Write-Host "The Cluster named Cluster 1 exists and available" -ForegroundColor Green
                $clustername | Set-Cluster -DrsEnabled:$true -Confirm:$false -HAAdmissionControlEnabled:$false
                    $vswitch = Get-VirtualSwitch | Where-Object {$_.Name -eq "vSwitch0"} 
                        $vswitch | New-VirtualPortGroup -Name "LAB Network" -VlanId $vlan_ID
            }
        
        if (!$clustername)

            {
                Wirte-Host "THe Cluster named Cluster 1 doesn't exists and need to be created" -ForegroundColor Red
            }

}
