SEC401 Win VM Notes

Winget commands 401 win VM


winget install --id 9P7KNL5RWT25 --location "C:\Program Files" --accept-package-agreements --accept-source-agreements

winget install --id voidtools.Everything   --accept-package-agreements --accept-source-agreements

winget search everthing
winget search everything
winget install --id voidtools.Everything   --accept-package-agreements --accept-source-agreements
winget uninstall --id 9P7KNL5RWT25
winget search firefox
winget install  Mozilla.Firefox
winget search chrome
winget install Google.Chrome

winget uninstall {572E990E-67FD-4014-884C-A730BFC7E1D7}
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe
winget uninstall Microsoft.BingNews_8wekyb3d8bbwe
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3r
winget uninstall Microsoft.MicrosoftSolitaireCollection
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe
winget uninstall Microsoft.OneDrive
winget uninstall Microsoft.OneDriveSync_8wekyb3d8bbwe
winget uninstall Microsoft.People_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe
winget uninstall MicrosoftTeams_8wekyb3d8bbwe

## Services info from PowerShell

get-services - lists all services
```
# All services matching the service names in the list provided

get-service -name wdfilter, wuauserv, mpssvc,  *windefend*  | sort-object -property status, displayname  | format-table -property status, name, displayname, starttype, requiredservices -autosize

All services matching the service displaynames in the list provided
get-service -displayname *defender*  | sort-object -property status, displayname  | format-table -autosize

```

### show all serives that have "update" in the output
$services = get-service |  ; $services | out-string -stream | select-string "update"
$services = get-service |  sort-object -property status,displayname  ; $services | out-string -stream | select-string "update"

Disabling windows update with Powershel. Two methods shown below.  The 1st on upsdartes the way the service starts up and the second just stops the service until it get started again (like a rebot)
Set-Service -Name "wuauserv" -Status stopped -StartupType disabled (or automatic)
Stop-Service -Name "wuauserv" -Force  (leaves the starttype set to automatic)

### Disable Firewall with PowerShell
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

Josh's disable steps for Windows Defender works on 
OS Name:                   Microsoft Windows 11 Enterprise
OS Version:                10.0.22000 N/A Build 22000
this was done with host only networking

### Check what happens when Windows Update runs (need to turn on NAT networking)
Turning NAT on and running Windows update will run and not restore the services.  If windows upadate has a Defender relatred update, those will fail.  I don't think this is a big deal but if we need to turn those services back on,  that will be a bit involved becasue Josh's process deletes the services,  not disables them..


### How to: Use PerfView to View Event Trace Data
https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/monitor-use-perfview-view-event-trace-data

### Turn off most notifications
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows" -Name "Explorer" -force
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -PropertyType "DWord" -Value 1
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -PropertyType "DWord" -Value 0

### Add local user
net user /add Walter ScienceRocks! 

### Add new local group 
New-LocalGroup -Name "Docker Users"
### Add students to Docker Users group
Add-LocalGroupMember -Group  "Docker Users" -Member "Student"

### Verify user and group membership
net user student 

## Docker Install

List of docker releases
https://download.docker.com/win/static/stable/x86_64/

### link to latest at the time
https://download.docker.com/win/static/stable/x86_64/docker-24.0.7.zip
"C:\Users\student\Downloads\docker-24.0.7.zip"

```
Expand-Archive "C:\Users\student\Downloads\docker-24.0.7.zip" -DestinationPath $Env:ProgramFiles
```

### Add Docker dir to the user env permanently  
```
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\docker", "User")
```

### Disable Hyper-V
Disable-WindowsOptionalFeature -FeatureName $feature_name -norestart -online

### Disable Hyper-V
Enable-WindowsOptionalFeature -FeatureName $feature_name -norestart -online



#### Determibne the state of Hyper-V
```
Get-WindowsOptionalFeature -Online | Where-Object -FilterScript {$_.featurename -Like "*Hyper*"}
```

### Remove Windows Feature
```

$ProgressPreference = 'SilentlyContinue'
$feature_name = "Microsoft-Hyper-V-All"
$feature_status = (Get-WindowsOptionalFeature -Online -FeatureName $feature_name).State
If($feature_status -eq "Enabled") {
	Write-Host $feature_name is $feature_status
  Write-Host Disabling $feature_name
	Disable-WindowsOptionalFeature -FeatureName $feature_name -norestart -online
}
else {
	Write-Host $feature_name is $feature_status , no action required.
}
``

### Restart computer from PowerShell
restart-computer

### Update Path
[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\Program Files\docker",
    [EnvironmentVariableTarget]::Machine)



### Docker Installation

#### Download Docker
$download_url   = "hhttps://download.docker.com/win/static/stable/x86_64/docker-24.0.7.zip"
$outfile = "c:\temp\docker.zip"
Invoke-WebRequest -Uri $download_url  -OutFile $outfile 
 
### Enable Windows Containers
```
Enable-WindowsOptionalFeature -FeatureName containers -norestart -online
``` 




### Enable Developer Mode 

##### Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}

##### Add registry value to enable Developer Mode
New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1 -Force





### Feature Related Commands

(Get-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All').State
Disable-WindowsOptionalFeature -online -FeatureName *Hyper* -All -norestart -online
Enable-WindowsOptionalFeature –Online -FeatureName *Hyper* -All -norestart -online


