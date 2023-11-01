<#
install system informer and trusted dll
#>

$ProgressPreference = 'SilentlyContinue'  # turn off progress box. greatly improves performance.
$program_files      = "c:\Program Files\"
$downloads          = "C:\Users\student\Downloads\"
$filter             = "informer"
$folder_name        = "SystemInformer\"
$si_path            = join-path -path $program_files -childpath $folder_name

# If SystemInformer folder already exists, delete any files in it.  Folder must exist.
If(test-path $si_path) {Remove-Item $si_path\* -Recurse -Force}

$download_url   = "https://github.com/winsiderss/si-builds/releases/download/3.0.7270/systeminformer-3.0.7270-setup.exe"  

$filename   	= [System.IO.Path]::GetFileName($download_url)  # parse out the file name from the download url  

Invoke-WebRequest -Uri $download_url  -OutFile $downloads\$filename  # download the app installer 

# Currenty, from GitHub issues, System Informer does not support silent installs.
Start-Process -Wait -FilePath (join-path -path $downloads -childpath $filename) -ArgumentList "/v','/qn" -passthru

# & "C:\Users\student\Downloads\systeminformer-3.0.7270-setup.exe" 
