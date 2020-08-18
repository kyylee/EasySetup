#!/bin/bash

TOOLDRCTRY="/root/tools"
mkdir ${TOOLDRCTRY}

export DEBIAN_FRONTEND=noninteractive;
echo "[*] Starting Install... [*]"
echo "[*] Upgrade installed packages to latest [*]"
echo -e "\nRunning a package upgrade...\n"
apt-get -qq update && apt-get -qq dist-upgrade -y
apt full-upgrade -y
apt-get autoclean

echo "" 

echo "[*] Install stuff I use all the time [*]"
echo -e "\nInstalling default packages...\n"
apt-get -y install build-essential checkinstall fail2ban gcc firefox git sqlite3 ruby ruby-dev git-core python-dev python-pip unzip jruby libbz2-dev libc6-dev libgdbm-dev libncursesw5-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev nikto nmap nodejs python-dev python-numpy python-scipy python-setuptools tk-dev unattended-upgrades wget curl
apt-get install -y xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps clang libdbus-1-dev libgtk2.0-dev libnotify-dev libgnome-keyring-dev libgconf2-dev libasound2-dev libcap-dev libcups2-dev libxtst-dev libxss1 libnss3-dev gcc-multilib g++-multilib libldns-dev

echo ""

read -p "Do you want to install go?" yn
case $yn in
        [Yy]* ) echo "[*] Install Go.[*]"
        wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
        echo "" >> .bashrc
        echo 'export PATH=$PATH:/usr/local/go/bin' >> .bashrc 
        source /root/.bashrc
        rm -rf go1.15.linux-amd64.tar.gz;;
        [Nn]* ) echo "Installation not will start";;
        * ) echo "Please answer yes (y or Y) or no (n or N)";;
esac

echo ""
source /root/.bashrc

read -p "Do you want to install chrome?" yn
case $yn in
        [Yy]* ) echo "[*] Install Chrome.[*]"
        wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
        dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
        apt-get -f install -y
        dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb;;
        [Nn]* ) echo "Installation not will start";;
        * ) echo "Please answer yes (y or Y) or no (n or N)";;
esac

echo ""
echo ""

echo "[*] Install nodejs [*]"
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

echo ""

cd ${TOOLDRCTRY}
echo "[*] Install Casperjs[*]"
git clone git://github.com/n1k0/casperjs.git
cd casperjs
ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
cd ..

echo ""
echo ""

read -p "Do you want to install Sublist3r?" yn
case $yn in
        [Yy]* ) echo "[*] Install Sublist3r.[*]"
            apt-get install sublist3r;;
        [Nn]* ) echo "Installation not will start";;
        * ) echo "Please answer yes (y or Y) or no (n or N)";;
esac

echo ""

echo "[*] install crlf injection[*]"
git clone https://github.com/random-robbie/CRLF-Injection-Scanner.git
cd CRLF-Injection-Scanner
pip install colored eventlet
cd ..

echo ""

echo "[*] pip install angularjs xss[*]"
git clone -b develop https://github.com/tijme/angularjs-csti-scanner.git
cd angularjs-csti-scanner
pip install -r requirements.txt
python setup.py install
wget "https://raw.githubusercontent.com/random-robbie/docker-dump/master/mass-angularjs-csti-scanner/mass-scan" -o /bin/mass-scan
wget "https://raw.githubusercontent.com/random-robbie/docker-dump/master/mass-angularjs-csti-scanner/scan" -o /bin/scan
chmod 777 /bin/scan
chmod 777 /bin/mass-scan
cd ..

echo ""

echo "[*] install subfinder [*]"

git clone https://github.com/projectdiscovery/subfinder.git
cd subfinder/cmd/subfinder
/usr/local/go/bin/go build .
mv subfinder /usr/local/bin/
subfinder -h
cd ../../../

echo ""

echo "[*] install ffuf [*]"

/usr/local/go/bin/go get github.com/ffuf/ffuf

echo ""

echo "[*] install OpenRedireX"

git clone https://github.com/devanshbatham/OpenRedireX
cd OpenRedireX
python3 -m venv env
cd ..

echo ""

echo "[*] install aquatone [*]"
gem install aquatone

echo ""

echo "[*] dir search [*]"
git clone https://github.com/maurosoria/dirsearch.git

echo ""

echo "[*] dirsearch mass [*]" 
wget https://gist.githubusercontent.com/random-robbie/b8fad5cbff2c5dbcb3470b6cd0c6d635/raw/dirsearch_it.sh -O /bin/dirsearch
chmod 777 /bin/dirsearch

echo ""

echo "[*] Go Buster [*]"
wget https://github.com/OJ/gobuster/archive/v1.3.tar.gz
tar xzvf v1.3.tar.gz
mv gobuster-1.3 go-buster
cd go-buster
wget https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/all.txt
/usr/local/go/bin/go build
chmod 777 gobuster
cd ..

echo ""

echo "[*] Mass DNS [*]"
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
make install
cd ..

echo ""

echo "[*] Sub Brute [*]"
git clone https://github.com/TheRook/subbrute.git

echo ""

echo "[*] S3 Bucket Checker [*]"
mkdir s3-bucket-check
cd s3-bucket-check
wget https://gist.githubusercontent.com/random-robbie/b452cc3e1aa99cfeba764e70b5a26dc8/raw/bucket_upload.sh
wget https://gist.githubusercontent.com/random-robbie/b0c8603e55e22b21c49fd80072392873/raw//bucket_list.sh
cd ..

echo ""

echo "[*] Expired Domain Take Overs [*]"
git clone https://github.com/JordyZomer/autoSubTakeover.git
cd autoSubTakeover
pip install -r requirements.txt
cd ..

echo ""

echo "[*] S3Cruze [*]"

git clone https://github.com/JR0ch17/S3Cruze.git

echo ""

echo "[*] install WaybackUrl [*]"

/usr/local/go/bin/go get github.com/tomnomnom/waybackurls

echo ""

echo "[*] install AssetFinder [*]"

/usr/local/go/bin/go get -u github.com/tomnomnom/assetfinder

echo ""

echo "[*] install httprobe [*]"

/usr/local/go/bin/go get -u github.com/tomnomnom/httprobe

echo ""

echo "[*] install Gitrob"

/usr/local/go/bin/go get github.com/michenriksen/gitrob
echo "[*****] Gitrob installation is done. You should export github acces token in .bashrc [****]"

echo ""

echo "[*] SecList [*]"

git clone https://github.com/danielmiessler/SecLists.git

echo ""

echo "[*] Creating Wordlist Directroy [*]"

mkdir wordlists
wget https://gist.githubusercontent.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt

echo ""

echo "[*]Finished Installing....[*]"
