@echo off
title TokenCross - Secure Token Grabbing Tool
color 2
mode con: cols=80 lines=25
cls


echo.
echo ==============================================
echo         TokenCross - Secure Tool
   by Crossflows
  ==============================================
echo.
echo Enter Discord ID: 
set /p discord_id=


for /f %%i in ('powershell -NoProfile -Command "[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('%discord_id%'))"') do set encoded_id=%%i


echo.
echo Enter Webhook URL: 
set /p webhook_url=


echo https://cdn.discordapp.com/avatars/%discord_id%/.png > avatar_url.txt
set /p avatar_url=<avatar_url.txt


echo { > webhook_data.json
echo   "username": "TokenCross", >> webhook_data.json
echo   "avatar_url": "%avatar_url%", >> webhook_data.json
echo   "embeds": [ >> webhook_data.json
echo     { >> webhook_data.json
echo       "title": "🔑 Token (Part):", >> webhook_data.json
echo       "description": "🚀 **This Contains only part of the token.**", >> webhook_data.json
echo       "color": 16776960, >> webhook_data.json
echo       "fields": [ >> webhook_data.json
echo         { >> webhook_data.json
echo           "name": "🆔 User ID:", >> webhook_data.json
echo           "value": "`%discord_id%`", >> webhook_data.json
echo           "inline": true >> webhook_data.json
echo         }, >> webhook_data.json
echo         { >> webhook_data.json
echo           "name": "🔐 Token (Part):", >> webhook_data.json
echo           "value": "`%encoded_id%`", >> webhook_data.json
echo           "inline": true >> webhook_data.json
echo         } >> webhook_data.json
echo       ], >> webhook_data.json
echo       "thumbnail": { "url": "%avatar_url%" }, >> webhook_data.json
echo       "footer": { "text": "🔹 Powered by TokenCross | Secure Token Tool" } >> webhook_data.json
echo     } >> webhook_data.json
echo   ] >> webhook_data.json
echo } >> webhook_data.json


powershell -NoProfile -Command "Invoke-WebRequest -Uri '%webhook_url%' -Method Post -ContentType 'application/json' -InFile 'webhook_data.json'"

echo.
echo ✅ Data successfully sent to the webhook!
echo.
pause
