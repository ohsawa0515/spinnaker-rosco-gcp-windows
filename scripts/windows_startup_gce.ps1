# Output with UTC-8
chcp 65001

# Output error message in english
[Threading.Thread]::CurrentThread.CurrentUICulture = 'en-US'

Write-Output "Setting up Packer user"
cmd.exe /c net user /add packer
cmd.exe /c net localgroup administrators packer /add
cmd.exe /c wmic useraccount where "name='packer'" set PasswordExpires=FALSE

winrm quickconfig -quiet
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true\"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

Stop-Service -Name winrm
Set-Service -Name winrm -Startup Automatic
Start-Service -Name winrm
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

