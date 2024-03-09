# Fedora-Post-Install-Automation
A script to automate standard actions after installing a Fedora system.

### Description

This bash script automates the setup of the Fedora system for gaming and work by performing the following actions:

1. Configuring DNF for faster package downloads.
2. Updating the system and installing the latest updates.
3. Enabling RPM Fusion and Flathub repositories.
4. Installing multimedia plugins and codecs.
5. Installing GNOME Tweaks and the extension management application.
6. Enabling "Minimize" or "Maximize" buttons.
7. Installing necessary applications such as Heroic Games Launcher, Steam, Discord, Telegram, and others.

### Installation

**Option 1: Install directly via curl and bash**

   ```bash
   curl -sSL https://github.com/SimonOriginal/Fedora-Post-Install-Automation/raw/main/fedora-ultimate-toolkit.sh | bash
   ```
**Option 2: Download and run the script manually**

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/SimonOriginal/Fedora-Post-Install-Automation/main/fedora-ultimate-toolkit.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x fedora-ultimate-toolkit.sh
   ```

3. Run the script with superuser privileges:
   ```bash
   sudo ./fedora-ultimate-toolkit.sh
   ```

### Usage

After running the script, all necessary system preparation actions will be performed. During the installation of applications, you will be prompted to choose the programs to install by entering their numbers separated by spaces. Enter 0 to continue without installing any programs.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
