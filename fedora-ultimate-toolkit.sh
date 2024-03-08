#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
        echo -e "${RED}Скрипт требует прав суперпользователя. Пожалуйста, запустите его с использованием sudo.${NC}"
        exit 1
    fi
}

# Check for sudo privileges
check_sudo

# Function to handle errors
handle_error() {
    echo -e "${RED}Ошибка: $1${NC}"
    # Skip the error and continue executing the script
    return 0
}


# Function to check for updates
check_for_updates() {
    sudo dnf check-update > /dev/null 2>&1
    return $?
}

# Step 1: Configure DNF for faster package downloads
echo -e "${YELLOW}Настройка DNF для более быстрой загрузки...${NC}"
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf || handle_error "Не удалось настроить DNF."
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf || handle_error "Не удалось настроить DNF."

# Update repository list
echo -e "${YELLOW}Обновление списка репозиториев...${NC}"
sudo dnf makecache || handle_error "Не удалось обновить список репозиториев."

# Step 2: Update the system
echo -e "${YELLOW}Обновление системы...${NC}"
sudo dnf update -y || handle_error "Не удалось обновить систему."

# Check for updates
echo -e "${YELLOW}Проверка наличия обновлений...${NC}"
if check_for_updates; then
    echo -e "${GREEN}Есть доступные обновления. Продолжение...${NC}"
else
    echo -e "${GREEN}Нет доступных обновлений. Переход к следующему шагу.${NC}"
fi

# Step 3: Enable RPM Fusion repository
echo -e "${YELLOW}Включение репозитория RPM Fusion...${NC}"
if ! rpm -q rpmfusion-free-release &> /dev/null || ! rpm -q rpmfusion-nonfree-release &> /dev/null; then
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm || handle_error "Не удалось установить RPM Fusion."
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || handle_error "Не удалось установить RPM Fusion."
else
    echo -e "${GREEN}Репозиторий RPM Fusion уже включен.${NC}"
fi

# Step 4: Enable Flathub repository
echo -e "${YELLOW}Включение репозитория Flathub...${NC}"
if ! flatpak remote-list | grep -q flathub; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || handle_error "Не удалось добавить репозиторий Flathub."
else
    echo -e "${GREEN}Репозиторий Flathub уже включен.${NC}"
fi

# Step 5: Install multimedia plugins
echo -e "${YELLOW}Установка мультимедийных плагинов...${NC}"
sudo dnf install -y vlc gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel lame\* --exclude=lame-devel || handle_error "Не удалось установить мультимедийные плагины."
sudo dnf group upgrade --with-optional Multimedia || handle_error "Не удалось обновить группу мультимедийных пакетов."

# Step 6: Install GNOME Tweaks and extension management application
echo -e "${YELLOW}Установка GNOME Tweaks и приложения для управления расширениями...${NC}"
sudo dnf install -y gnome-tweaks gnome-extensions-app || handle_error "Не удалось установить GNOME Tweaks и приложение для управления расширениями."

# Step 7: Enable 'Minimize' or 'Maximize' buttons
echo -e "${YELLOW}Включение кнопок 'Свернуть' или 'Развернуть'...${NC}"
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close' || handle_error "Не удалось настроить кнопки 'Свернуть' или 'Развернуть'."

# Step 8: Install necessary applications
echo -e "${YELLOW}Установка необходимых приложений...${NC}"

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
echo -e "${YELLOW}Выберите программы для установки (введите номера через пробел):${NC}"
for i in "${!programs[@]}"; do
    echo "$((i+1)). ${programs[$i]}"
done
echo "Введите 0, чтобы продолжить без установки программ."
read -r -p "Номера программ: " -a selected_indices
for index in "${selected_indices[@]}"; do
    if ((index == 0)); then
        break
    elif ((index > 0 && index <= ${#programs[@]})); then
        selected_programs+=("${programs[$((index-1))]}")
    else
        echo -e "${RED}Неверный номер программы: $index${NC}"
    fi
done

for program in "${selected_programs[@]}"; do
    if ! flatpak list | grep -q "$program"; then
        install_flatpak_package "$program" || handle_error "Не удалось установить программу $program."
    else
        echo -e "${GREEN}Программа $program уже установлена.${NC}"
        update_flatpak_package "$program" || handle_error "Не удалось обновить программу $program."
    fi
done

echo -e "${GREEN}Установка и обновление программ завершены.${NC}"