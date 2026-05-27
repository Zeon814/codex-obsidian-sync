@echo off
setlocal

cd /d "%~dp0.."
if "%OBSIDIAN_VAULT%"=="" set "OBSIDIAN_VAULT=D:\Documents\Obsidian Vault"

set "PYTHON_EXE="
if exist "C:\Users\Administrator\anaconda3\python.exe" set "PYTHON_EXE=C:\Users\Administrator\anaconda3\python.exe"
if "%PYTHON_EXE%"=="" if exist "%LocalAppData%\hermes\hermes-agent\venv\Scripts\python.exe" set "PYTHON_EXE=%LocalAppData%\hermes\hermes-agent\venv\Scripts\python.exe"
if "%PYTHON_EXE%"=="" if exist "%AppData%\uv\python\cpython-3.11-windows-x86_64-none\python.exe" set "PYTHON_EXE=%AppData%\uv\python\cpython-3.11-windows-x86_64-none\python.exe"

echo Starting Codex Obsidian Sync...
echo Project: %CD%
echo Vault: %OBSIDIAN_VAULT%
echo Python: %PYTHON_EXE%
echo.

if "%PYTHON_EXE%"=="" (
    echo Could not find Python. Install Python or add it to PATH, then run this script again.
    goto stopped
)

"%PYTHON_EXE%" "%~dp0watch_codex_sessions.py" %*

:stopped
echo.
echo Codex Obsidian Sync has stopped. Press any key to close this window.
pause >nul
