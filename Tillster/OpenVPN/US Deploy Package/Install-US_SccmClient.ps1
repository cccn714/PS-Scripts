New-Item -ItemType Directory -Path C:\Client
Copy-Item -Path \\kiosk-sccm01.tillsterkiosk.com\Software\Client\* -Destination C:\Client -Recurse
cd C:\Client
.\ccmsetup /mp:kiosk-sccm01.tillsterkiosk.com SMSSITECODE=TK1 SMSMP=kiosk-sccm01.tillsterkiosk.com