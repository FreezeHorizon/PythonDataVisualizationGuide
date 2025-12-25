#!/bin/bash

echo "========================================"
echo "Python Setup and Jupyter Notebook Installer"
echo "========================================"
echo

# Check if Python is already installed
echo "[Step 1] Checking for Python installation..."
if command -v python3 &> /dev/null; then
    echo "Python is already installed!"
    python3 --version
    echo
else
    echo "Python not found. Installing Python..."
    
    # Detect OS and install Python accordingly
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            # Debian/Ubuntu
            sudo apt-get update
            sudo apt-get install -y python3 python3-pip
        elif command -v yum &> /dev/null; then
            # RedHat/CentOS
            sudo yum install -y python3 python3-pip
        elif command -v pacman &> /dev/null; then
            # Arch Linux
            sudo pacman -S python python-pip
        else
            echo "ERROR: Unable to detect package manager. Please install Python manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install python3
        else
            echo "ERROR: Homebrew not found. Please install Homebrew first or install Python manually."
            echo "Visit: https://brew.sh/"
            exit 1
        fi
    else
        echo "ERROR: Unsupported operating system."
        exit 1
    fi
    
    echo "Python installation complete!"
    echo
fi

# Upgrade pip
echo "[Step 2] Checking and upgrading pip..."
python3 -m pip install --upgrade pip
echo

# Check and install Jupyter Notebook
echo "[Step 3] Checking for Jupyter Notebook..."
if python3 -m pip show jupyter &> /dev/null; then
    echo "Jupyter Notebook is already installed!"
else
    echo "Installing Jupyter Notebook..."
    python3 -m pip install jupyter notebook
fi
echo

# Check and install pandas
echo "[Step 4] Checking for pandas..."
if python3 -m pip show pandas &> /dev/null; then
    echo "pandas is already installed!"
else
    echo "Installing pandas..."
    python3 -m pip install pandas
fi
echo

# Check and install seaborn
echo "[Step 5] Checking for seaborn..."
if python3 -m pip show seaborn &> /dev/null; then
    echo "seaborn is already installed!"
else
    echo "Installing seaborn..."
    python3 -m pip install seaborn
fi
echo

echo "========================================"
echo "All checks and installations complete!"
echo "========================================"
echo
echo "Launching Jupyter Notebook in 3 seconds..."
sleep 3

# Launch Jupyter Notebook
jupyter notebook

echo
echo "Press any key to exit..."
read -n 1