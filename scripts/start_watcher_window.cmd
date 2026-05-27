@echo off
setlocal

if "%CODEX_OBSIDIAN_SYNC_WINDOW%"=="1" goto run_watcher

set "CODEX_OBSIDIAN_SYNC_WINDOW=1"
start "Codex Obsidian Sync" "%~f0" %*
exit /b

:run_watcher
cd /d "%~dp0.."
python "%~dp0watch_codex_sessions.py" %*
echo.
echo Codex Obsidian Sync has stopped. Press any key to close this window.
pause >nul
