# list-disabled-services.ps1

Get-Service | Where-Object { $_.StartType -eq 'Disabled' } |
Select-Object Name, DisplayName, Status |
Format-Table -AutoSize