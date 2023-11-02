<#
Script description here
#>

$repo_path            = "C:Temp\401_vm"
$temp_install_dir     = "C:\Temp"
$ssh_dir              = $env:USERPROFILE + "\" + ".ssh"
$ssh_key_name         = "id_rsa-401-vms.pub"
$ssh_full_path        = $ssh_dir + "\" +  $ssh_key_name
$config_full_path     = $ssh_dir + "\" +  "config"

$config_file_contents = 
@"
Host github.com
User git
IdentityFile ~/.ssh/for498_workbook_id_rsa
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
"@ 

$ssh_key 					= @"
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
"@


# use here string to create a multi-line file.  There can't be any white space after the @" 

# Create .ssh dir if it doesn't exit.
If (!(test-path $ssh_dir)) {New-Item -ItemType Directory -Force -Path $ssh_dir}

# create ssh key for 401_vms repo
set-content -path (join-path $ssh_dir $ssh_key_name)  -value $ssh_key

# create ssh config for 401_vms repo ssh commands
set-content -path $ssh_full_path -value $ssh_key

# Create temp installation dir if if has not already been created
If (!(test-path $temp_instal_dir)) {New-Item -ItemType Directory -Force -Path $temp_install_dir}

# Remove vm repo if it already exists  delete the files in the dir but leave the folder
If (!(test-path $repo_path)) {Remove-Item $repo_path -Recurse -Force}

# Create ssh pub (read-only) key
set-content -path $ssh_full_path -value $ssh_key

# Create ssh config file
set-content -path $config_full_path -value $config_file_contents

ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:sans-sroc/sec401-vms.git $repo_path --quiet



