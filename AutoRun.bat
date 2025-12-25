@echo off
echo ========================================
echo Python Setup and Jupyter Notebook Installer
echo ========================================
echo.

REM Check if Python is already installed
echo [Step 1/6] Checking for Python installation...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python is already installed!
    python --version
    echo.
    goto :skip_python_install
)

REM Download Python installer
echo Python not found. Downloading Python installer...
set PYTHON_VERSION=3.12.0
set INSTALLER_NAME=python-%PYTHON_VERSION%-amd64.exe
curl -o %INSTALLER_NAME% https://www.python.org/ftp/python/%PYTHON_VERSION%/%INSTALLER_NAME%

if not exist %INSTALLER_NAME% (
    echo ERROR: Failed to download Python installer
    pause
    exit /b 1
)

echo Download complete!
echo.

REM Install Python
echo [Step 2/6] Installing Python...
echo Please wait, this may take a few minutes...
start /wait %INSTALLER_NAME% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

echo Python installation complete!
echo.

REM Clean up installer
echo Cleaning up installer file...
del %INSTALLER_NAME%
echo.

:skip_python_install

REM Upgrade pip
echo [Step 3/6] Checking and upgrading pip...
python -m pip install --upgrade pip
echo.

REM Check and install Jupyter Notebook
echo [Step 4/6] Checking for Jupyter Notebook...
pip show jupyter >nul 2>&1
if %errorlevel% equ 0 (
    echo Jupyter Notebook is already installed!
) else (
    echo Installing Jupyter Notebook...
    pip install jupyter notebook
)
echo.

REM Check and install pandas
echo [Step 5/6] Checking for pandas...
pip show pandas >nul 2>&1
if %errorlevel% equ 0 (
    echo pandas is already installed!
) else (
    echo Installing pandas...
    pip install pandas
)
echo.

REM Check and install seaborn
echo [Step 6/6] Checking for seaborn...
pip show seaborn >nul 2>&1
if %errorlevel% equ 0 (
    echo seaborn is already installed!
) else (
    echo Installing seaborn...
    pip install seaborn
)
echo.

echo ========================================
echo All checks and installations complete!
echo ========================================
echo.
echo Launching Jupyter Notebook...
timeout /t 3 /nobreak >nul

REM Launch Jupyter Notebook
jupyter notebook

pause