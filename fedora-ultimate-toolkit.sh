#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

LANGUAGE="en"  # Set default language to English, options: "uk" (Ukrainian), "en" (English)

# Translation keys and values
declare -A TRANSLATIONS_UK
declare -A TRANSLATIONS_EN
declare -A ERROR_TRANSLATIONS_UK
declare -A ERROR_TRANSLATIONS_EN

TRANSLATIONS_UK=(
    ["script_requires_sudo"]="Скрипт вимагає прав суперкористувача. Будь ласка, запустіть його з використанням sudo."
    ["error"]="Помилка: "
    ["configuring_dnf"]="Налаштування DNF для швидшого завантаження..."
    ["updating_repo_list"]="Оновлення списку репозиторіїв..."
    ["updating_system"]="Оновлення системи..."
    ["checking_updates"]="Перевірка наявності оновлень..."
    ["available_updates"]="Є доступні оновлення. Продовження..."
    ["no_available_updates"]="Немає доступних оновлень. Перехід до наступного кроку."
    ["enabling_rpm_fusion"]="Увімкнення репозиторію RPM Fusion..."
    ["rpm_fusion_already_enabled"]="Репозиторій RPM Fusion вже увімкнено."
    ["enabling_flathub"]="Увімкнення репозиторію Flathub..."
    ["flathub_already_enabled"]="Репозиторій Flathub вже увімкнено."
    ["installing_multimedia_plugins"]="Встановлення мультимедійних плагінів..."
    ["installing_gnome_tweaks"]="Встановлення GNOME Tweaks та програми для управління розширеннями..."
    ["enabling_minimize_maximize"]="Увімкнення кнопок 'Зменшити' або 'Збільшити'..."
    ["installing_necessary_apps"]="Встановлення необхідних програм..."
    ["select_apps_to_install"]="Виберіть програми для встановлення (введіть номери через пробіл):"
    ["continue_without_apps"]="Введіть 0, щоб продовжити без встановлення програм."
    ["invalid_app_number"]="Невірний номер програми: "
    ["app_already_installed"]="Програма вже встановлена."
    ["installing_gnome_extensions"]="Встановлення розширень GNOME..."
    ["gnome_extension_already_installed"]="Розширення GNOME вже встановлено."
)

TRANSLATIONS_EN=(
    ["script_requires_sudo"]="The script requires superuser privileges. Please run it using sudo."
    ["error"]="Error: "
    ["configuring_dnf"]="Configuring DNF for faster package downloads..."
    ["updating_repo_list"]="Updating repository list..."
    ["updating_system"]="Updating the system..."
    ["checking_updates"]="Checking for updates..."
    ["available_updates"]="There are available updates. Continuing..."
    ["no_available_updates"]="No available updates. Moving to the next step."
    ["enabling_rpm_fusion"]="Enabling RPM Fusion repository..."
    ["rpm_fusion_already_enabled"]="RPM Fusion repository is already enabled."
    ["enabling_flathub"]="Enabling Flathub repository..."
    ["flathub_already_enabled"]="Flathub repository is already enabled."
    ["installing_multimedia_plugins"]="Installing multimedia plugins..."
    ["installing_gnome_tweaks"]="Installing GNOME Tweaks and extension management application..."
    ["enabling_minimize_maximize"]="Enabling 'Minimize' or 'Maximize' buttons..."
    ["installing_necessary_apps"]="Installing necessary applications..."
    ["select_apps_to_install"]="Select applications to install (enter numbers separated by space):"
    ["continue_without_apps"]="Enter 0 to continue without installing applications."
    ["invalid_app_number"]="Invalid application number: "
    ["app_already_installed"]="Application already installed."
    ["installing_gnome_extensions"]="Installing GNOME extensions..."
    ["gnome_extension_already_installed"]="GNOME extension already installed."
    ["select_extensions_to_install"]="Виберіть розширення GNOME для встановлення (введіть номери через пробіл):"
    ["continue_without_extensions"]="Введіть 0, щоб продовжити без встановлення розширень."
    ["extension_numbers"]="Номери розширень: "
    ["invalid_extension_number"]="Невірний номер розширення: "
    ["extensions_installed_updated"]="Розширення GNOME встановлені та оновлені."
)

ERROR_TRANSLATIONS_UK=(
    ["cannot_configure_dnf"]="Не вдалося налаштувати DNF."
    ["cannot_update_repo_list"]="Не вдалося оновити список репозиторіїв."
    ["cannot_update_system"]="Не вдалося оновити систему."
    ["cannot_install_rpm_fusion"]="Не вдалося встановити RPM Fusion."
    ["cannot_add_flathub_repo"]="Не вдалося додати репозиторій Flathub."
    ["cannot_install_multimedia_plugins"]="Не вдалося встановити мультимедійні плагіни."
    ["cannot_install_gnome_tweaks"]="Не вдалося встановити GNOME Tweaks і програму для управління розширеннями."
    ["cannot_set_minimize_maximize"]="Не вдалося налаштувати кнопки 'Зменшити' або 'Збільшити'."
    ["cannot_install_flatpak_package"]="Не вдалося встановити пакет Flatpak."
    ["cannot_install_gnome_extension"]="Не вдалося встановити розширення GNOME."
)

ERROR_TRANSLATIONS_EN=(
    ["cannot_configure_dnf"]="Cannot configure DNF."
    ["cannot_update_repo_list"]="Cannot update repository list."
    ["cannot_update_system"]="Cannot update the system."
    ["cannot_install_rpm_fusion"]="Cannot install RPM Fusion."
    ["cannot_add_flathub_repo"]="Cannot add Flathub repository."
    ["cannot_install_multimedia_plugins"]="Cannot install multimedia plugins."
    ["cannot_install_gnome_tweaks"]="Cannot install GNOME Tweaks and extension management application."
    ["cannot_set_minimize_maximize"]="Cannot set 'Minimize' or 'Maximize' buttons."
    ["cannot_install_flatpak_package"]="Cannot install Flatpak package."
    ["cannot_install_gnome_extension"]="Cannot install GNOME extension."
    ["select_extensions_to_install"]="Select GNOME extensions to install (enter numbers separated by space):"
    ["continue_without_extensions"]="Enter 0 to continue without installing extensions."
    ["extension_numbers"]="Extension numbers: "
    ["invalid_extension_number"]="Invalid extension number: "
    ["extensions_installed_updated"]="GNOME extensions installed and updated."
)

# Function to get the translated string
translate() {
    local key="$1"
    if [ "${LANGUAGE}" == "uk" ]; then
        echo "${TRANSLATIONS_UK[$key]}"
    elif [ "${LANGUAGE}" == "en" ]; then
        echo "${TRANSLATIONS_EN[$key]}"
    fi
}

# Function to install packages through Flatpak
install_flatpak_package() {
    flatpak install -y flathub "$1"
}

# Function to update packages through Flatpak
update_flatpak_package() {
    flatpak update -y "$1"
}

# Function to check for sudo privileges
check_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}$(translate "script_requires_sudo")${NC}"
        exit 1
    fi
}

# Check for sudo privileges
check_sudo

# Function to handle errors
handle_error() {
    local error_key="$1"
    if [ "${LANGUAGE}" == "uk" ]; then
        echo -e "${RED}$(translate "error")${ERROR_TRANSLATIONS_UK[$error_key]}${NC}"
    elif [ "${LANGUAGE}" == "en" ]; then
        echo -e "${RED}$(translate "error")${ERROR_TRANSLATIONS_EN[$error_key]}${NC}"
    fi
    # Skip the error and continue executing the script
    return 0
}

# Function to check for updates
check_for_updates() {
    sudo dnf check-update > /dev/null 2>&1
    return $?
}

# Step 1: Configure DNF for faster package downloads
echo -e "${YELLOW}$(translate "configuring_dnf")${NC}"
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf || handle_error "cannot_configure_dnf"
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf || handle_error "cannot_configure_dnf"

# Update repository list
echo -e "${YELLOW}$(translate "updating_repo_list")${NC}"
sudo dnf makecache || handle_error "cannot_update_repo_list"

# Step 2: Update the system
echo -e "${YELLOW}$(translate "updating_system")${NC}"
sudo dnf update -y || handle_error "cannot_update_system"

# Check for updates
echo -e "${YELLOW}$(translate "checking_updates")${NC}"
if check_for_updates; then
    echo -e "${GREEN}$(translate "available_updates")${NC}"
else
    echo -e "${GREEN}$(translate "no_available_updates")${NC}"
fi

# Step 3: Enable RPM Fusion repository
echo -e "${YELLOW}$(translate "enabling_rpm_fusion")${NC}"
if ! rpm -q rpmfusion-free-release &> /dev/null || ! rpm -q rpmfusion-nonfree-release &> /dev/null; then
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm || handle_error "cannot_install_rpm_fusion"
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || handle_error "cannot_install_rpm_fusion"
else
    echo -e "${GREEN}$(translate "rpm_fusion_already_enabled")${NC}"
fi

# Step 4: Enable Flathub repository
echo -e "${YELLOW}$(translate "enabling_flathub")${NC}"
if ! flatpak remote-list | grep -q flathub; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || handle_error "cannot_add_flathub_repo"
else
    echo -e "${GREEN}$(translate "flathub_already_enabled")${NC}"
fi

# Step 5: Install multimedia plugins
echo -e "${YELLOW}$(translate "installing_multimedia_plugins")${NC}"
sudo dnf install -y vlc gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel lame\* --exclude=lame-devel || handle_error "cannot_install_multimedia_plugins"
sudo dnf group upgrade --with-optional Multimedia || handle_error "cannot_install_multimedia_plugins"

# Step 6: Install GNOME Tweaks and extension management application
echo -e "${YELLOW}$(translate "installing_gnome_tweaks")${NC}"
sudo dnf install -y gnome-tweaks gnome-extensions-app || handle_error "cannot_install_gnome_tweaks"

# Step 7: Enable 'Minimize' or 'Maximize' buttons
echo -e "${YELLOW}$(translate "enabling_minimize_maximize")${NC}"
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close' || handle_error "cannot_set_minimize_maximize"

# Step 8: Install necessary applications
echo -e "${YELLOW}$(translate "installing_necessary_apps")${NC}"

# Install programs through Flatpak
programs=(
    "com.heroicgameslauncher.hgl"
    "com.valvesoftware.Steam"
    "com.discordapp.Discord"
    "org.telegram.desktop"
    "com.github.zocker_160.SyncThingy"
    "im.fluffychat.Fluffychat"
    "org.peazip.PeaZip"
    "org.keepassxc.KeePassXC"
    "org.qbittorrent.qBittorrent"
    "org.onlyoffice.desktopeditors"
    "md.obsidian.Obsidian"
    "io.github.peazip.PeaZip"
    "com.vscodium.codium"
    "io.github.jeffshee.Hidamari"
)

selected_programs=()
echo -e "${YELLOW}$(translate "select_apps_to_install")${NC}"
for i in "${!programs[@]}"; do
    echo "$((i+1)). ${programs[$i]}"
done
echo "$(translate "continue_without_apps")"
read -r -p "$(translate "app_numbers")" -a selected_indices
for index in "${selected_indices[@]}"; do
    if ((index == 0)); then
        break
    elif ((index > 0 && index <= ${#programs[@]})); then
        selected_programs+=("${programs[$((index-1))]}")
    else
        echo -e "${RED}$(translate "invalid_app_number")$index${NC}"
    fi
done

for program in "${selected_programs[@]}"; do
    if ! flatpak list | grep -q "$program"; then
        install_flatpak_package "$program" || handle_error "cannot_install_flatpak_package"
    else
        echo -e "${GREEN}$(translate "app_already_installed") $program${NC}"
        update_flatpak_package "$program" || handle_error "cannot_install_flatpak_package"
    fi
done

echo -e "${GREEN}$(translate "apps_installed_updated")${NC}"

