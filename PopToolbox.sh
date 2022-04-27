#!/bin/bash

CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

echo -e "             ${CYAN}/////////////                
         /////////////////////            
      ///////${WHITE}*767${CYAN}////////////////         
    //////${WHITE}7676767676*${CYAN}//////////////       
   /////${WHITE}76767${CYAN}//${WHITE}7676767${CYAN}//////////////      
  /////${WHITE}767676${CYAN}///${WHITE}*76767${CYAN}///////////////     
 ///////${WHITE}767676${CYAN}///${WHITE}76767.${CYAN}///${WHITE}7676*${CYAN}///////    
/////////${WHITE}767676${CYAN}//${WHITE}76767${CYAN}///${WHITE}767676${CYAN}////////   
//////////${WHITE}76767676767${CYAN}////${WHITE}76767${CYAN}/////////   
///////////${WHITE}76767676${CYAN}//////${WHITE}7676${CYAN}//////////   
////////////${WHITE},7676,${CYAN}///////${WHITE}767${CYAN}///////////   
/////////////${WHITE}*7676${CYAN}///////${WHITE}76${CYAN}////////////   
///////////////${WHITE}7676${CYAN}////////////////////    
 ///////////////${WHITE}7676${CYAN}///${WHITE}767${CYAN}////////////   
  //////////////////////${WHITE}'${CYAN}////////////     
   //////${WHITE}.7676767676767676767,${CYAN}//////      
    /////${WHITE}767676767676767676767${CYAN}/////       
      ///////////////////////////         
         /////////////////////
             /////////////${NC}                                         
"

echo "Welcome to Pop_OS! Toolbox please select an option"

updateSystem() {
  echo "Updating packages"

  sudo apt update
  apt list --upgradeable
  sudo apt upgrade

  flatpak update
}

cleanupSystem() {
  echo "Cleaning up Pop_OS!"

  sudo apt autopurge
  sudo apt autoclean

  flatpak uninstall --unused --delete-data
}

upgradeSystem() {
  echo "Upgrading to the latest Pop_OS! version"

  sudo apt update
  sudo apt full-upgrade
  pop-upgrade release upgrade
  reboot
}

reboot() {
  read -p "Reboot and upgrade system? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || return
  sudo reboot
}

malwareScan() {
  echo "Running chkrootkit package"

  sudo apt install chkrootkit

  sudo chkrootkit
}

killGraphicalEnviroment() {
  echo "Killing Gnome Shell Session"

  killall -3 gnome-shell
}

resetDisplayManager() {
  echo "Restarting the Display Manager"

  sudo systemctl restart gdm
}

resetNetworking() {
  echo "Restarting the networking service"

  sudo systemctl restart networking
}

aptRecovery() {
  echo "Attempting to recover apt..."

  sudo dpkg --configure -a
  sudo apt update
  sudo apt install --fix-broken
  sudo apt install --fix-missing
}

flatpakRecovery() {  
  echo "Installing flatpak"

  sudo apt install flatpak

  echo "Adding Repositories"

  flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

flatpakRepair() {
  echo "Attempting to repair flatpak..."

  flatpak repair
}

startupServices() {
  echo "Displaying CRITICAL chain of on boot starup services"

  sudo systemd-analyze critical-chain

  echo "Use:"
  echo "systemctl enable/disable <service>"
  echo "To enable/disable services as daemons"
}

installAptPackage() {
  echo "Install an apt package"
  read -p "Enter package name to install: " package

  sudo apt install ${package}
}

removeAptPackage() {
  echo "Remove an apt package"
  read -p "Enter package name to remove: " package

  sudo apt remove ${package}
}

findInstalledAptPackage() {
  echo "Find an installed apt package"
  read -p "Enter search query: " searchQuery

  apt list --installed | grep ${searchQuery} --ignore-case --color=auto
}

findRemoteAptPackage() {
  echo "Find an remote apt package"
  read -p "Enter search query: " searchQuery

  apt list | grep ${searchQuery} --ignore-case --color=auto
}

listAllInstalledAptPackages() {
  echo "Listing all installed apt packages"

  apt list --installed
}

listAllRemoteAptPackages() {
  echo "Listing all remote apt packages"

  apt list | more
}

installFlatpakPackage() {
  echo "Install a flatpak package"
  read -p "Enter package name to install: " package

  flatpak install ${package}
}

uninstallFlatpakPackage() {
  echo "Uninstall a flatpak package"
  read -p "Enter package name to uninstall: " package

  flatpak uninstall ${package}
}

findInstalledFlatpakPackage() {
  echo "Find an installed flatpak package"
  read -p "Enter search query: " searchQuery

  flatpak list | grep ${searchQuery} --ignore-case --color=auto
}

findRemoteFlatpakPackage() {
  echo "Find an installed flatpak package"
  read -p "Enter search query: " searchQuery

  flatpak remote-ls | grep ${searchQuery} --ignore-case --color=auto
}

listAllInstalledFlatpakPackages() {
  echo "Listing installed flatpak packages"

  flatpak list
}

listAllRemoteFlatpakPackages() {
  echo "Listing all remote flatpak packages"

  flatpak remote-ls | more
}

restrictHosts() {
  sudo bash -c 'curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts > /etc/hosts' 
}

defaultHosts() {
  sudo bash -c 'echo "127.0.0.1	localhost
::1		localhost
127.0.1.1	pop-os.localdomain	pop-os" > /etc/hosts'
}

systemManagement() {
  local PS3='Please enter your choice: '
  local options=("Back" "Pop_OS! Update System" "Pop_OS! Cleanup System" "Pop_OS! Upgrade To The Next OS Version" "Run Malware Scan")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Pop_OS! Update System")
      updateSystem
      ;;
    "Pop_OS! Cleanup System")
      cleanupSystem
      ;;
    "Pop_OS! Upgrade To The Next OS Version")
      upgradeSystem
      ;;
    "Run Malware Scan")
      malwareScan
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

aptQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Install An apt Package" "Remove An apt Package" "Find Installed apt Package" "Search For Remote apt Package" "List All Installed apt Packages" "List All Remote apt Packages")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Install An apt Package")
      installAptPackage
      ;;
    "Remove An apt Package")
      removeAptPackage
      ;;
    "Find Installed apt Package")
      findInstalledAptPackage
      ;;
    "Search For Remote apt Package")
      findRemoteAptPackage
      ;;
    "List All Installed apt Packages")
      listAllInstalledAptPackages
      ;;
    "List All Remote apt Packages")
      listAllRemoteAptPackages
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

flatpakQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Install A Flatpak Package" "Uninstall A Flatpak Package" "Find Installed Flatpak Package" "Search For Remote Flatpak Package" "List All Installed Flatpak Packages" "List All Remote Flatpak Packages")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Install A Flatpak Package")
      installFlatpakPackage
      ;;
    "Uninstall A Flatpak Package")
      uninstallFlatpakPackage
      ;;
    "Find Installed Flatpak Package")
      findInstalledFlatpakPackage
      ;;
    "Search For Remote Flatpak Package")
      findRemoteFlatpakPackage
      ;;
    "List All Installed Flatpak Packages")
      listAllInstalledFlatpakPackages
      ;;
    "List All Remote Flatpak Packages")
      listAllRemoteFlatpakPackages
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

packageQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "apt Package Querying" "Flatpak Package Querying")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "apt Package Querying")
      aptQuery
      ;;
    "Flatpak Package Querying")
      flatpakQuery
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

performance() {
  local PS3='Please enter your choice: '
  local options=("Back" "Check On Boot Startup Services")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Check On Boot Startup Services")
      startupServices
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

systemRecovery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Kill Graphical Enviroment" "Hard Reset Of Display Manager" "Reset Networking" "apt Recovery" "Flatpak Recovery" "Flatpak Repair")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Kill Graphical Enviroment")
      killGraphicalEnviroment
      ;;
    "Hard Reset Of Display Manager")
      resetDisplayManager
      ;;
    "Reset Networking")
      resetNetworking
      ;;
    "apt Recovery")
      aptRecovery
      ;;
    "Flatpak Recovery")
      flatpakRecovery
      ;;
    "Flatpak Repair")
      flatpakRepair
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

hosts() {
  PS3='Please enter your choice: '
  options=("Back" "Restrict Hosts File" "Pop_OS! Default Hosts File")
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Restrict Hosts File")
      restrictHosts
      ;;
    "Pop_OS! Default Hosts File")
      defaultHosts
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

main() {
  PS3='Please enter your choice: '
  options=("Quit" "Pop_OS! Management" "Pop_OS! Package Query" "Pop_OS! Performance" "Pop_OS! Recovery" "Pop_OS! Hosts")
  select opt in "${options[@]}"; do
    case $opt in
    "Quit")
      break
      ;;
    "Pop_OS! Management")
      systemManagement
      ;;
    "Pop_OS! Package Query")
      packageQuery
      ;;
    "Pop_OS! Performance")
      performance
      ;;
    "Pop_OS! Recovery")
      systemRecovery
      ;;
    "Pop_OS! Hosts")
      hosts
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

main
