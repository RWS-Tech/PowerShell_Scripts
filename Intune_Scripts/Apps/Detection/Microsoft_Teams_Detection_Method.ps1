$AppVersion = "x.x.xx.xxxxx"
Function Get-LoggedOnUserSID {
## ref https://www.reddit.com/r/PowerShell/comments/7coamf/query_no_user_exists_for/
## ref https://smsagent.blog/2022/03/03/user-context-detection-rules-for-intune-win32-apps/
$header=@('SESSIONNAME', 'USERNAME', 'ID', 'STATE', 'TYPE', 'DEVICE')
$Sessions = query session
[array]$ActiveSessions = $Sessions | Select -Skip 1 | Where {$_ -match "Active"}
If ($ActiveSessions.Count -ge 1)
{
$LoggedOnUsers = @()
$indexes = $header | ForEach-Object {($Sessions[0]).IndexOf(" $_")}
for($row=0; $row -lt $ActiveSessions.Count; $row++)
{
$obj=New-Object psobject
for($i=0; $i -lt $header.Count; $i++)
{
$begin=$indexes[$i]
$end=if($i -lt $header.Count-1) {$indexes[$i+1]} else {$ActiveSessions[$row].length}
$obj | Add-Member NoteProperty $header[$i] ($ActiveSessions[$row].substring($begin, $end-$begin)).trim()
}
$LoggedOnUsers += $obj
}
$LoggedOnUser = $LoggedOnUsers[0]
$LoggedOnUserSID = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData\$($LoggedOnUser.ID)" -Name LoggedOnUserSID -ErrorAction SilentlyContinue |
Select -ExpandProperty LoggedOnUserSID
Return $LoggedOnUserSID
}
}
$LoggedOnUserSID = Get-LoggedOnUserSID
If ($null -ne $LoggedOnUserSID)
{
If ($null -eq (Get-PSDrive -Name HKU -ErrorAction SilentlyContinue))
{
$null = New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
}
$i = Get-Item "HKU:\$LoggedOnUserSID\Software\Microsoft\Windows\CurrentVersion\Uninstall\Teams" -ErrorAction SilentlyContinue
if ($null -eq $i)
{
## Key Does NOT Exist
"Key Does NOT Exist"
Exit 1
}
else
{
$r = Get-ItemProperty "HKU:\$LoggedOnUserSID\Software\Microsoft\Windows\CurrentVersion\Uninstall\Teams" -Name 'DisplayVersion' -ErrorAction SilentlyContinue |
Select -ExpandProperty 'DisplayVersion'
If ($r -ge $AppVersion)
{
## Installed
"Installed"
Exit 0
}
else
{
## Correct App Version NOT Installed
"Correct App Version NOT Installed"
Exit 1
}
}
}
Else
{
## No Logged on User Detected
"No Logged on User Detected"
Exit 1
}
