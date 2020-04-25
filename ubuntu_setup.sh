##Linux Install

##basics
sudo apt-get install curl gdebi unzip git gnome-tweak-tool httpie unzip openvpn net-tools make network-manager-openvpn powertop nvidia-settings gparted mariadb-client-core-10.1 lm-sensors chrome-gnome-shell kazam

##virtal box
sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install virtualbox-5.2

##vagrant
curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
sudo apt install ./vagrant_2.2.6_x86_64.deb

##ansible
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

##Albert
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_18.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install albert

##php
sudo apt install php-fpm
systemctl status php7.2-fpm
sudo apt install php-mysql php-dom php-zip php-redis php7.2-apcu php-curl php7.2-mbstring

##TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update
sudo apt install tlp tlp-rdw

##Disable Nvidia card
sudo apt install acpi acpi-call-dkms
sudo echo '_SB.PCI0.PEG0.PEGP._OFF' | sudo tee /proc/acpi/call
temp and battery life should decrease and increaste respectively now
might need to run this command as roo sudo -s
To automate on startup, do the following as root:

echo acpi_call > /etc/modules-load.d/acpi_call.conf
sudo touch /usr/lib/systemd/user/dgpu-off.service

##add these contents

[Unit]
Description=Power-off dGPU
After=graphical.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c "echo '\\_SB.PCI0.PEG0.PEGP._OFF' | sudo tee /proc/acpi/call; cat /proc/acpi/call > /tmp/nvidia-off"

[Install]
WantedBy=graphical.target

systemctl enable /usr/lib/systemd/user/dgpu-off.service
After a reboot 
cat /tmp/nvidia-off 
should report 0x0called and the idle temp should be about 10° lower.

##Composer install
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

##Install phive
wget -O phive.phar "https://phar.io/releases/phive.phar"
wget -O phive.phar.asc "https://phar.io/releases/phive.phar.asc"
gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 0x9D8A98B29B2D5D79
gpg --verify phive.phar.asc phive.phar
rm phive.phar.asc
chmod +x phive.phar
sudo mv phive.phar /usr/local/bin/phive


##fancontrol
sudo echo "options dell-smm-hwmon restricted=0 force=1" > /etc/modprobe.d/dell-smm-hwmon.conf
sudo echo "dell-smm-hwmon" > /etc/modules
sudo update-initramfs -u

##i8kutils
http://keenformatics.blogspot.com/2013/06/how-to-solve-dell-laptops-fan-issues-in.html

##yarn install
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
yarn add npm
npm rebuild node-sass`

##et notifications to the right of the screen
sudo apt install chrome-gnome-shell
Then go https://extensions.gnome.org/ using Firefox or Google Chrome. The webpage should ask you to install a browser add-on/extension, install it.
https://extensions.gnome.org/extension/708/panel-osd/
gnome-shell-extension-prefs ##enable the extension and setup

