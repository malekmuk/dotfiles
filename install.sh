#!/bin/bash

# User-configurable variables
SUDO="sudo"                   # Path to sudo command (e.g., 'sudo' or '' if root)
PKG="apt"                      # Package manager (e.g., 'apt', 'dnf', 'pacman')
PKG_UPDATE="update" 
PKG_UPGRADE="upgrade -y"
PKG_OPTS="install -y"          # Options to pass to the package manager (e.g., '-y' for apt)
INSTALL_LIST=(
    "curl" "git" "vim" "neovim" "helix" "ripgrep" "alacritty" "tmux"
    "clang" "rustup" "htop" "btop" "neofetch"
)  # List of apps to install

# Arrays to store successful and failed installations
SUCCESS_LIST=()
FAIL_LIST=()
ALREADY_INSTALLED_LIST=()

# Define the check for installed packages depending on the package manager
case "$PKG" in
    apt)
        PKG_CHECK="dpkg-query -W -f='${Status}'"  # For apt-based systems
        ;;
    dnf)
        PKG_CHECK="dnf list installed"            # For dnf-based systems
        ;;
    pacman)
        PKG_CHECK="pacman -Q"                     # For pacman-based systems
        ;;
    *)
        echo "Error: Unsupported package manager $PKG"
        exit 1
        ;;
esac

# Function to check if the package manager is available
check_package_manager() {
    if ! command -v $PKG &> /dev/null; then
        echo "Error: $PKG is not installed. Exiting."
        exit 1
    fi
}

# Generalized function to check if a package is installed using $PKG_CHECK
is_package_installed() {
    local package="$1"
    
    # Execute the check based on the $PKG_CHECK variable
    $PKG_CHECK $package &>/dev/null
    return $?  # Return exit status of the check
}

# Function to install the necessary packages
install_packages() {
    echo "Installing packages..."
    for package in "${INSTALL_LIST[@]}"; do
        if is_package_installed "$package"; then
            echo "$package is already installed. Skipping..."
            ALREADY_INSTALLED_LIST+=("$package")
        else
            echo "Installing $package..."
            if $SUDO $PKG $PKG_OPTS $package; then
                SUCCESS_LIST+=("$package")
            else
                FAIL_LIST+=("$package")
            fi
        fi
    done
}

# Function to install a specific app (used to add more packages individually)
install_app() {
    local app="$1"
    if is_package_installed "$app"; then
        echo "$app is already installed. Skipping..."
        ALREADY_INSTALLED_LIST+=("$app")
    else
        echo "Installing $app..."
        if $SUDO $PKG $PKG_OPTS $app; then
            SUCCESS_LIST+=("$app")
        else
            FAIL_LIST+=("$app")
        fi
    fi
}

# Function to update and upgrade system packages
update_system() {
   echo "Updating package list..."
   $SUDO $PKG $PKG_UPDATE && $SUDO $PKG $PKG_UPDATE
}

# Main script execution
echo "Bootstrapping a fresh system installation..."

# Check if the package manager exists
check_package_manager

# Perform system update and upgrade
update_system

# Install the listed packages
install_packages

# Optionally, you can install more packages manually if needed
# install_app "some-additional-package"

# Summary of installations
echo ""
echo "Bootstrap complete!"
echo "====================="
echo "Successfully installed packages:"
if [ ${#SUCCESS_LIST[@]} -eq 0 ]; then
    echo "No packages were successfully installed."
else
    for pkg in "${SUCCESS_LIST[@]}"; do
        echo "  - $pkg"
    done
fi

echo ""
echo "Already installed packages (skipped):"
if [ ${#ALREADY_INSTALLED_LIST[@]} -eq 0 ]; then
    echo "No packages were skipped."
else
    for pkg in "${ALREADY_INSTALLED_LIST[@]}"; do
        echo "  - $pkg"
    done
fi

echo ""
echo "Failed to install packages:"
if [ ${#FAIL_LIST[@]} -eq 0 ]; then
    echo "No packages failed to install."
else
    for pkg in "${FAIL_LIST[@]}"; do
        echo "  - $pkg"
    done
fi
