@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "PYTHON_SCRIPT=%SCRIPT_DIR%hypo.py"

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Python not found.
    exit /b 1
)

python "%PYTHON_SCRIPT%" %*
