#!/bin/bash
# Add Kali Linux repositories
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list

# Import Kali Linux repository GPG key
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

# Update package lists
sudo apt update
sudo apt install golang-go
#Installing tools 
mkdir ~/tools
cd ~/tools
git clone https://github.com/gotr00t0day/spyhunt
pip3 install -r ~/tools/spyhunt/requirements.txt
sudo python3 spyhunt/install.py
sudo rm -rf ~/tools/spyhunt/spyhunt.py
wget -P ~/tools/spyhunt https://raw.githubusercontent.com/Anhedoniczz/ReconZ/main/Resources/spyhunt.py
git clone https://github.com/s0md3v/XSStrike
pip3 install -r ~/tools/XSStrike/requirements.txt
wget -P ~/tools/XSStrike https://raw.githubusercontent.com/Anhedoniczz/Reconz/main/Resources/autoxss.sh
chmod +x ~/tools/XSStrike/autoxss.sh
sudo apt-get install httpx-toolkit
pip3 install uro
pip3 install google
sudo mv ~/.local/share/bin/uro /usr/bin/
sudo apt-get install nuclei
sudo apt-get install subfinder
git clone https://github.com/s0md3v/Corsy
pip3 install -r ~/tools/Corsy/requirements.txt
go install github.com/bitquark/shortscan/cmd/shortscan@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/tomnomnom/gf@latest
mkdir ~/.gf
cd 
git clone https://github.com/1ndianl33t/Gf-Patterns
sudo mv Gf-Patterns/*.json ~/.gf
rm -rf Gf-Patterns

