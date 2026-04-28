@echo off
set "ps_script=%temp%\toggle_taskbar.ps1"
echo $p = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' > "%ps_script%"
echo $rs = Get-ItemProperty $p >> "%ps_script%"
echo $v = $rs.Settings >> "%ps_script%"
echo if ($v[8] -eq 3) { $v[8] = 2 } else { $v[8] = 3 } >> "%ps_script%"
echo Set-ItemProperty -Path $p -Name Settings -Value $v >> "%ps_script%"
psexec -i 1 powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%"

taskkill /f /im explorer.exe
start explorer.exe

del "%ps_script%"
