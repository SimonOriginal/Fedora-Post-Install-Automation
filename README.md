# Fedora-Post-Install-Automation
A script to automate standard actions after installing a Fedora system.

**Description**

This bash script automates the setup of the Fedora system for gaming and work by performing the following actions:

1. Configuring DNF for faster package downloads.
2. Updating the system and installing the latest updates.
3. Enabling RPM Fusion and Flathub repositories.
4. Installing multimedia plugins and codecs.
5. Installing GNOME Tweaks and the extension management application.
6. Enabling "Minimize" or "Maximize" buttons.
7. Installing necessary applications such as Heroic Games Launcher, Steam, Discord, Telegram, and others.

**Installation**

Copy the script to your system:

```bash
wget https://raw.githubusercontent.com/SimonOriginal/Fedora-Post-Install-Automation/main/fedora-ultimate-toolkit.sh
```

Make the script executable:

```bash
chmod +x fedora-setup.sh
```

Run the script with superuser privileges:

```bash
sudo ./fedora-setup.sh
```

### Usage

After running the script, all necessary system preparation actions will be performed. During the installation of applications, you will be prompted to choose the programs to install by entering their numbers separated by spaces. Enter 0 to continue without installing any programs.

### License

This project is licensed under the MIT License - see the LICENSE file for details.
