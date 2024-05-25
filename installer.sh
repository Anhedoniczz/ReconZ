#!/bin/bash
# Add Kali Linux repositories
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list

# Import Kali Linux repository GPG key
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

# Update package lists
sudo apt update
sudo apt install golang-go
pip3 install google
pip3 install huepy
#Installing tools 
mkdir ~/tools
cd ~/tools
git clone https://github.com/gotr00t0day/spyhunt
pip3 install -r ~/tools/spyhunt/requirements.txt
sudo python3 spyhunt/install.py
sudo rm -rf ~/tools/spyhunt/spyhunt.py
wget -P ~/tools/spyhunt https://raw.githubusercontent.com/Anhedoniczz/ReconZ/main/Resources/spyhunt.py
git clone https://github.com/felipemelchior/gouro
cd gouro
rm -rf main.go
cp ~/ReconZ/Resources/gouro.go ~/tools/gouro/main.go
export GOPATH=$HOME/gopath
export PATH=$PATH:$GOPATH/bin
go build ./...
sudo mv gouro ~/gopath/bin
git clone https://github.com/m4ll0k/SecretFinder
pip3 install -r ~/tools/SecretFinder/requirements.txt
git clone https://github.com/s0md3v/XSStrike
pip3 install -r ~/tools/XSStrike/requirements.txt
wget -P ~/tools/XSStrike https://raw.githubusercontent.com/Anhedoniczz/Reconz/main/Resources/autoxss.sh
chmod +x ~/tools/XSStrike/autoxss.sh
sudo apt-get install httpx-toolkit
sudo pip3 install -r requirements.txt
sudo mv ~/.local/bin/uro /usr/bin/
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/felipemelchior/gouro@latest
go install github.com/rix4uni/xsschecker@latest
go install github.com/tomnomnom/qsreplace@latest
git clone https://github.com/s0md3v/Corsy
pip3 install -r ~/tools/Corsy/requirements.txt
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/tomnomnom/gf@latest
mkdir ~/.gf
cd 
git clone https://github.com/1ndianl33t/Gf-Patterns
sudo mv Gf-Patterns/*.json ~/.gf
rm -rf Gf-Patterns
