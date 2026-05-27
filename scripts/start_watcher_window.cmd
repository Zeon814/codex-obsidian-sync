@echo off
setlocal

start "Codex Obsidian Sync" cmd /k ""%~dp0run_watcher.cmd" %*"
