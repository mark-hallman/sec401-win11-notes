<#

This script will build/install as much of the FOR401-WIN11-VM as can reasonabley be scripted.

#>

# Run the intial setup script
& .\intial_setup.ps1

# Remove notifications
Write-Host "Disabling Notifications"
& .\disable_notifications.ps1

Write-Host "You will need to manually complete the Install Dialog boxes."
& .\system_informer_instll.ps1

