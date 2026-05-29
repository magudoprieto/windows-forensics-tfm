@echo off
echo === RECOPILACIÓN DE DATOS VOLÁTILES ===
date /t && time /t
ipconfig /all
netstat -naob
arp -a
tasklist /v
net share
sc query
pause