$vm = Get-VM <Guest-with-triggered-alarm> | Get-View

foreach($daState in $vm.DeclaredAlarmState){
	if($daState.OverallStatus -eq "red"){
		$alarm = Get-View $daState.Alarm
		continue
	}
}

$spec = [VMware.Vim.AlarmSpec]$alarm.Info
$alarm.ReconfigureAlarm($spec)





<#$vm = Get-VM NTNX-16SM6B260135-A-CVM | Get-View

foreach($daState in $vm.DeclaredAlarmState){
	if($daState.OverallStatus -eq "red"){
		$alarm = Get-View $daState.Alarm
		continue
	}
}

$spec = [VMware.Vim.AlarmSpec]$alarm.Info
$alarm.ReconfigureAlarm($spec) #>



