Add-DnsServerResourceRecordA -Name "ntnx-objects" -ZoneName "ntnxlab.local" -AllowUpdateAny -IPv4Address "10.55.47.18"}
Invoke-Command -ComputerName dc.ntnxlab.local -ScriptBlock {Add-DnsServerResourceRecordA -Name "user01-k10.ntnx-objects" -ZoneName "ntnxlab.local" -AllowUpdateAny -IPv4Address "10.55.47.18"}




https://10.55.47.39:9440/api/nutanix/v3/action_rules/trigger

ce6160e7-e144-468c-948f-763433506e03