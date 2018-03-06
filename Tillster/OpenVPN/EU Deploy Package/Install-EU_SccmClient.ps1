New-Item -ItemType Directory -Path C:\Client
Copy-Item -Path \\kiosk-sccm02.tillsterkiosk.com\E$\Client\* -Destination C:\Client -Recurse
cd C:\Client
.\ccmsetup /mp:kiosk-sccm02.tillsterkiosk.com SMSSITECODE=TK1 SMSMP=kiosk-sccm02.tillsterkiosk.com
Copy-Item "C:\EU Deploy\cmtrace.exe" -Destination "C:\Windows\System32"