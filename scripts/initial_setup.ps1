<#
scripts that initlize the build environment
#>

# Create the Temp dir for storing installtion files
# Create temp installation dir
If (!(test-path $temp_instal_dir)) {New-Item -ItemType Directory -Force -Path $temp_install_dir}

# Use winget to remove unnedded apps
& .\debloat_with_winget.ps1

#  Clone the vm repo that contains lab specific files used in this vm build
& .\clone_vm_repo.ps1

