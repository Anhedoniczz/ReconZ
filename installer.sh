#!/bin/bash
# Add Kali Linux repositories
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list

# Import Kali Linux repository GPG key
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

# Update package lists
sudo apt update
sudo apt install golang-go
pip3 install google --break-system-packages.
pip3 install huepy --break-system-packages.
#Installing tools 
mkdir ~/tools
cd ~/tools
git clone https://github.com/s0md3v/uro/
cd uro
python3 setup.py sdist 
cd dist
pip3 install * --break-system-packages.
cd ../..
sudo apt-get install httpx-toolkit
sudo pip3 install -r ~/ReconZ/requirements.txt --break-system-packages.
sudo mv ~/.local/bin/uro /usr/bin/
sudo apt-get install nuclei
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/rix4uni/xsschecker@latest
go install github.com/tomnomnom/qsreplace@latest
git clone https://github.com/s0md3v/Corsy
pip3 install -r ~/tools/Corsy/requirements.txt --break-system-packages.
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/KathanP19/Gxss@latest
go install github.com/hahwul/dalfox/v2@latest
go install github.com/tomnomnom/gf@latest
mkdir ~/.gf
cd 
git clone https://github.com/1ndianl33t/Gf-Patterns
sudo mv Gf-Patterns/*.json ~/.gf
rm -rf Gf-Patterns
