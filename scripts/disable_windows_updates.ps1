<#
Disable Windows Udpates
#>

Write-Host  Disabling Windows Updates
#disable the update service
sc.exe config wuauserv start=disabled
sc.exe stop wuauserv
sc.exe query wuauserv

#disable auto downloads
$AUSettings = (New-Object -com "Microsoft.Update.AutoUpdate").Settings
$AUSettings.NotificationLevel = 1
$AUSettings.Save