@echo off
title TokenCross - Secure Token Grabbing Tool - by Crossflows
color 2
mode con: cols=80 lines=25
cls


echo Enter Discord ID: 
set /p discord_id=


for /f %%i in ('powershell -NoProfile -Command "[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('%discord_id%'))"') do set encoded_id=%%i


echo Enter Webhook URL: 
set /p webhook_url=


echo { > webhook_data.json
echo   "username": "TokenCross", >> webhook_data.json
echo   "avatar_url": "https://example.com/avatar.png", >> webhook_data.json
echo   "embeds": [ >> webhook_data.json
echo     { >> webhook_data.json
echo       "title": "🔒  < < Cracked Token > >", >> webhook_data.json
echo       "description": "✅ **Token (Part):** `%encoded_id%`", >> webhook_data.json
echo       "color": 65280, >> webhook_data.json
echo       "footer": { "text": "Powered by TokenCross" } >> webhook_data.json
echo     } >> webhook_data.json
echo   ] >> webhook_data.json
echo } >> webhook_data.json


powershell -NoProfile -Command "Invoke-WebRequest -Uri '%webhook_url%' -Method Post -ContentType 'application/json' -InFile 'webhook_data.json'"

echo.
echo ✅ Data sent to webhook successfully!
echo.
pause
